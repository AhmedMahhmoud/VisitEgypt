import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:visit_egypt/Core/Colors/app_colors.dart';
import 'package:visit_egypt/Core/Shared/methods.dart';
import 'package:visit_egypt/Features/Home/View/Cubit/trips_cubit.dart';

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
          final tripsList = BlocProvider.of<TripsCubit>(context).tripsList;
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
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: ListView.separated(
                      shrinkWrap: true,
                      separatorBuilder: (context, index) => SizedBox(
                        height: 20.h,
                      ),
                      itemBuilder: (context, index) {
                        return Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white,
                              boxShadow: const [
                                BoxShadow(
                                    blurRadius: 1,
                                    spreadRadius: 2,
                                    offset: Offset(0, 2))
                              ]),
                          height: 230.h,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: DefaultTextStyle(
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                              textAlign: TextAlign.center,
                              child: Column(
                                children: [
                                  const Center(
                                    child: Icon(Icons.info),
                                  ),
                                  const Divider(),
                                  Row(
                                    children: [
                                      const AutoSizeText('Trip Type :'),
                                      AutoSizeText(
                                          tripsList[index].locations.length == 1
                                              ? 'Single Place'
                                              : 'Multiple Places')
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      const AutoSizeText('Trip Meeting Day :'),
                                      AutoSizeText(tripsList[index].dayOfMeet)
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      const AutoSizeText('Trip Meeting Time :'),
                                      AutoSizeText(tripsList[index].timeOfMeet)
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      const AutoSizeText('Price :'),
                                      AutoSizeText(tripsList[index]
                                          .totalPrice
                                          .toString())
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      const AutoSizeText(
                                          'Tourists joined number :'),
                                      AutoSizeText(tripsList[index]
                                          .numberOfJoiners
                                          .toString())
                                    ],
                                  ),
                                  const Divider(
                                    thickness: 1,
                                    color: Colors.grey,
                                  ),
                                  MaterialButton(
                                    color: tripsList[index].numberOfJoiners > 2
                                        ? CustomColors.blackK
                                        : Colors.grey,
                                    onPressed: () {
                                      if (tripsList[index].numberOfJoiners <
                                          2) {
                                        ConstantMethods.showContentToast(
                                            context,
                                            "Can't start trip with less than 2 tourists",
                                            true);
                                      }
                                    },
                                    child: Center(
                                      child: Text(
                                        tripsList[index].isStarted
                                            ? "End Trip"
                                            : "Start Trip",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: CustomColors.whiteK),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      itemCount: tripsList.length,
                    ),
                  ),
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
