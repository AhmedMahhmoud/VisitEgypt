import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:visit_egypt/Core/Colors/app_colors.dart';
import 'package:visit_egypt/Core/Constants/constants.dart';
import 'package:visit_egypt/Features/Home/View/Cubit/trips_cubit.dart';
import 'package:visit_egypt/Features/More/views/more_screen.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz;
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
                  SizedBox(
                    width: 150.w,
                    child: MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      color: Colors.black,
                      onPressed: () async {
                        final TimeOfDay? picked = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                          builder: (BuildContext context, Widget? child) {
                            return Theme(
                              data: ThemeData(
                                colorScheme: const ColorScheme.light(
                                  primary: CustomColors
                                      .niceOrange, // change the primary color
                                ),
                              ),
                              child: MediaQuery(
                                data: MediaQuery.of(context)
                                    .copyWith(alwaysUse24HourFormat: true),
                                child: child!,
                              ),
                            );
                          },
                        );
                        //adding the time to fire base
                        // Convert TimeOfDay to DateTime
                        if (picked != null) {
                          tz.initializeTimeZones();
                          final timeZone = tz.getLocation('Africa/Cairo');
                          final now = tz.TZDateTime.now(timeZone);
                          final time = tz.TZDateTime(timeZone, now.year,
                              now.month, now.day, picked.hour, picked.minute);
                          // Store DateTime as timestamp in Firebase
                          var timetz = tz.TZDateTime.from(time, tz.local);
                          final firebaseTimestamp = Timestamp.fromDate(timetz);
                          await FirebaseFirestore.instance
                              .collection(Constants.notificationTime)
                              .doc('timeDoc')
                              .set({'time': firebaseTimestamp});
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text("Time changed successfully")));
                        }
                      },
                      child: const Center(
                          child: Text(
                        "Notifications Time",
                        style: TextStyle(color: Colors.white),
                      )),
                    ),
                  ),
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
