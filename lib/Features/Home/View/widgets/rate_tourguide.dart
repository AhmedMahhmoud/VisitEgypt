import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lottie/lottie.dart';
import 'package:rating_dialog/rating_dialog.dart';
import 'package:flutter/material.dart';
import 'package:visit_egypt/Core/Constants/constants.dart';
import 'package:visit_egypt/Features/Home/Model/tourguide_trip.dart';

import '../../../../Core/Shared/methods.dart';

class DisplayRatingTourguideDialog extends StatelessWidget {
  final TripModel tripModel;
  const DisplayRatingTourguideDialog({required this.tripModel, super.key});

  @override
  Widget build(BuildContext context) {
    return RatingDialog(
        showCloseButton: true,
        message: const Text(
          'Tap a star to set your rating. Add more description here if you want.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 15),
        ),
        image: Lottie.network(
            "https://assets6.lottiefiles.com/packages/lf20_4iOVbbgerL.json",
            width: 120,
            height: 120),
        commentHint: 'Write your trip review',
        title: const Text(""),
        submitButtonText: "Submit",
        onSubmitted: (p0) async {
          var trips = await FirebaseFirestore.instance
              .collection(Constants.allTrips)
              .get();
          var x = trips.docs.firstWhere(
              (element) => element.data()['tripID'] == tripModel.tripID);
          var idList = tripModel.usersJoinedIDs;

          idList!.removeWhere(
              (element) => element == FirebaseAuth.instance.currentUser!.uid);
          var id = x.id;
          await FirebaseFirestore.instance
              .collection(Constants.allTrips)
              .doc(id)
              .update({'usersJoinedIds': idList});
          // ignore: use_build_context_synchronously
          ConstantMethods.showContentToast(
              context, "Review added successfully!");
        });
  }
}
