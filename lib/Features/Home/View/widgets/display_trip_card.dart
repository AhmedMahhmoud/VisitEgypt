import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:visit_egypt/Core/Colors/app_colors.dart';
import 'package:visit_egypt/Core/Shared/methods.dart';
import 'package:visit_egypt/Features/Home/Model/tourguide_trip.dart';
import 'package:visit_egypt/Features/Home/View/Cubit/trips_cubit.dart';
import 'package:visit_egypt/Features/Home/View/widgets/rate_tourguide.dart';

import 'credit_card_display.dart';
import 'package:url_launcher/url_launcher.dart';

class DisplayTripCard extends StatefulWidget {
  const DisplayTripCard({
    super.key,
    required this.tripsList,
  });

  final List<TripModel> tripsList;

  @override
  State<DisplayTripCard> createState() => _DisplayTripCardState();
}

class _DisplayTripCardState extends State<DisplayTripCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
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
                      blurRadius: 1, spreadRadius: 2, offset: Offset(0, 2))
                ]),
            height: 270.h,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: DefaultTextStyle(
                style: const TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.black),
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
                            widget.tripsList[index].locations.length == 1
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
                        AutoSizeText(widget.tripsList[index].dayOfMeet)
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        const AutoSizeText('Trip Meeting Time :'),
                        AutoSizeText(widget.tripsList[index].timeOfMeet)
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        const AutoSizeText('Price :'),
                        AutoSizeText(
                            widget.tripsList[index].totalPrice.toString())
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        const AutoSizeText('Tourists joined number :'),
                        AutoSizeText(
                            widget.tripsList[index].numberOfJoiners.toString())
                      ],
                    ),
                    const Divider(
                      thickness: 1,
                      color: Colors.grey,
                    ),
                    MaterialButton(
                      color: widget.tripsList[index].numberOfJoiners >= 2
                          ? CustomColors.blackK
                          : Colors.grey,
                      onPressed: () {
                        if (!widget.tripsList[index].isStarted) {
                          if (widget.tripsList[index].numberOfJoiners < 2) {
                            ConstantMethods.showContentToast(
                                context,
                                "Can't start trip with less than 2 tourists",
                                true);
                          } else {
                            BlocProvider.of<TripsCubit>(context)
                                .startTrip(widget.tripsList[index]);
                          }
                        } else {
                          BlocProvider.of<TripsCubit>(context)
                              .endTrip(widget.tripsList[index]);
                          widget.tripsList.remove(widget.tripsList[index]);
                          setState(() {});
                          ConstantMethods.showContentToast(
                            context,
                            "Trip ended successfully",
                          );
                        }
                      },
                      child: Center(
                        child: Text(
                          widget.tripsList[index].isStarted
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
        itemCount: widget.tripsList.length,
      ),
    );
  }
}

class DisplaySingleTripCardForTourist extends StatelessWidget {
  const DisplaySingleTripCardForTourist({
    super.key,
    required this.tripsList,
  });

  final List<TripModel> tripsList;

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                      blurRadius: 1, spreadRadius: 2, offset: Offset(0, 2))
                ]),
            height: 270.h,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: DefaultTextStyle(
                style: const TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.black),
                textAlign: TextAlign.center,
                child: Column(
                  children: [
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Container(),
                          ),
                          const Icon(Icons.info),
                          Expanded(
                            child: Container(),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: InkWell(
                              onTap: () async {
                                final url =
                                    "tel:${tripsList[index].tourGuideNumber}";
                                if (await canLaunchUrl(Uri.parse(url))) {
                                  await launchUrl(Uri.parse(url));
                                }
                                {}
                              },
                              child: const Icon(
                                Icons.phone,
                                color: Colors.green,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    const Divider(),
                    Row(
                      children: [
                        const AutoSizeText('Trip Type :'),
                        AutoSizeText(tripsList[index].locations.length == 1
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
                        AutoSizeText(tripsList[index].totalPrice.toString())
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        const AutoSizeText('No of tourists joined :'),
                        AutoSizeText(
                            tripsList[index].numberOfJoiners.toString())
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    tripsList[index].description!.isEmpty
                        ? const SizedBox()
                        : Row(
                            children: [
                              const AutoSizeText('description :'),
                              AutoSizeText(tripsList[index].description!)
                            ],
                          ),
                    const Divider(
                      thickness: 1,
                      color: Colors.grey,
                    ),
                    MaterialButton(
                      color: Colors.black,
                      onPressed: tripsList[index].hasEnded
                          ? () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return Column(
                                      children: [
                                        DisplayRatingTourguideDialog(
                                            tripModel: tripsList[index]),
                                      ],
                                    );
                                  });
                            }
                          : tripsList[index].isStarted
                              ? () {}
                              : !tripsList[index].usersJoinedIDs!.contains(
                                      FirebaseAuth.instance.currentUser!.uid)
                                  ? () {
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return Dialog(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15)),
                                                elevation: 16,
                                                child: Container(
                                                    color: Colors.black
                                                        .withOpacity(0.9),
                                                    height: 800.h,
                                                    width: double.infinity,
                                                    child: CreditCardDisplay(
                                                      tourGuideID:
                                                          tripsList[index]
                                                              .userID,
                                                      trip: tripsList[index],
                                                      tripID: tripsList[index]
                                                          .tripID!,
                                                    )));
                                          });
                                    }
                                  : () {
                                      if (tripsList[index].numberOfJoiners >
                                          4) {
                                        ConstantMethods.showContentToast(
                                            context,
                                            "Can't cancel number of joiners > 4",
                                            true);
                                      } else {
                                        BlocProvider.of<TripsCubit>(context)
                                            .joinTrip(
                                                tripsList[index].tripID!,
                                                tripsList[index].userID,
                                                tripsList[index]);
                                      }
                                    },
                      child: Center(
                        child: Text(
                          tripsList[index].hasEnded
                              ? 'Trip ended tap to rate tourist'
                              : tripsList[index].usersJoinedIDs!.contains(
                                      FirebaseAuth.instance.currentUser!.uid)
                                  ? tripsList[index].isStarted
                                      ? 'Trip is in progress'
                                      : 'Cancel Join'
                                  : 'Join trip',
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
    );
  }
}
