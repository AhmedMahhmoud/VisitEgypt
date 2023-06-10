import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visit_egypt/Core/Colors/app_colors.dart';
import 'package:visit_egypt/Features/Home/View/Cubit/trips_cubit.dart';
import 'package:visit_egypt/Features/More/views/more_screen.dart';

import '../widgets/pending_guides_display.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  @override
  void initState() {
    BlocProvider.of<TripsCubit>(context).getPendingGuides();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.lightGold,
      appBar: AppBar(
        backgroundColor: Colors.black.withOpacity(0.5),
        title: const Text(
          "Pending tourguides",
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(8),
        child: BlocBuilder<TripsCubit, TripsState>(
          buildWhen: (previous, current) =>
              previous is PendingGuidesLoadingState,
          builder: (context, state) {
            if (state is PendingGuidesLoadingState) {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            } else if (state is PendingGuidesLoaded) {
              return Column(
                children: [
                  PendingGuidesDisplay(
                    state: state,
                  ),
                  const Spacer(),
                  const LogOut()
                ],
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
