import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:visit_egypt/Core/Colors/app_colors.dart';
import 'package:visit_egypt/Core/Constants/constants.dart';
import 'package:visit_egypt/Features/Home/Model/tourguide_trip.dart';
import 'package:visit_egypt/Features/Home/View/Cubit/trips_cubit.dart';

import '../widgets/display_multiple_trip_card.dart';
import '../widgets/display_trip_card.dart';

class AllTripsScreen extends StatefulWidget {
  final String locationName;
  const AllTripsScreen({required this.locationName, super.key});

  @override
  State<AllTripsScreen> createState() => _AllTripsScreenState();
}

class _AllTripsScreenState extends State<AllTripsScreen> {
  int pageIndex = 0;
  @override
  Widget build(BuildContext context) {
    var tripsCubit = BlocProvider.of<TripsCubit>(context);
    return Scaffold(
      backgroundColor: CustomColors.niceYellow,
      body: SafeArea(
        child: BlocBuilder<TripsCubit, TripsState>(
          builder: (context, state) {
            if (state is TripsLoadingState) {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            }
            return SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: ListView(
                  children: [
                    SizedBox(
                        child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(22),
                      ),
                      child: DefaultTabController(
                        length: 2,
                        child: TabBar(
                          indicator: BoxDecoration(
                            color: CustomColors.whiteK,
                            borderRadius: BorderRadius.circular(22),
                          ),
                          labelStyle: TextStyle(
                              fontSize: 16.sp, fontWeight: FontWeight.bold),
                          labelColor: Colors.black,
                          unselectedLabelColor: Colors.white,
                          onTap: (value) {
                            setState(() {
                              pageIndex = value;
                            });
                          },
                          tabs: const [
                            Tab(
                              text: "Single Place",
                            ),
                            Tab(
                              text: "Multiple Places",
                            )
                          ],
                        ),
                      ),
                    )),
                    const SizedBox(
                      height: 20,
                    ),
                    StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                        stream: FirebaseFirestore.instance
                            .collection(Constants.allTrips)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (snapshot.hasData) {
                            List<TripModel> allTrips = [];
                            for (var element in snapshot.data!.docs) {
                              allTrips.add(TripModel.fromMap(element.data()));
                            }

                            return pageIndex == 0
                                ? DisplaySingleTripCardForTourist(
                                    tripsList: allTrips
                                        .where((element) => (element.locations.contains(widget.locationName) &&
                                                element.locations.length == 1 &&
                                                (element.hasEnded == false) ||
                                            (element.hasEnded &&
                                                element.usersJoinedIDs!.contains(FirebaseAuth
                                                    .instance
                                                    .currentUser!
                                                    .uid))))
                                        .toList())
                                : DisplayMiultipleTripCardForTourist(
                                    tripsList: allTrips
                                        .where((element) =>
                                            element.locations.length > 1 &&
                                            element.locations.contains(widget.locationName))
                                        .where((element) => element.hasEnded == false)
                                        .toList());
                          }
                          return Container();
                        })
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
