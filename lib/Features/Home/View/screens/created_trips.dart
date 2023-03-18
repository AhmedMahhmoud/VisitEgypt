import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:visit_egypt/Core/Colors/app_colors.dart';
import 'package:visit_egypt/Features/Home/View/Cubit/trips_cubit.dart';

import '../widgets/display_trip_card.dart';

class CreatedTripsPage extends StatefulWidget {
  const CreatedTripsPage({super.key});

  @override
  State<CreatedTripsPage> createState() => _CreatedTripsPageState();
}

class _CreatedTripsPageState extends State<CreatedTripsPage> {
  @override
  void initState() {
    BlocProvider.of<TripsCubit>(context)
      ..resetState()
      ..getCreatedTrips();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.lightGold,
      body: BlocBuilder<TripsCubit, TripsState>(builder: (context, state) {
        if (state is TripsLoadingState) {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        } else {
          final tripsList = BlocProvider.of<TripsCubit>(context).tripsListByID;
          return Padding(
            padding: const EdgeInsets.all(10),
            child: Center(
              child: ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  Center(
                      child: Text(
                    "My trips",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),
                  )),
                  const Divider(),
                  DisplayTripCard(tripsList: tripsList),
                  const SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
          );
        }
      }),
    );
  }
}
