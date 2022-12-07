import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:rating_dialog/rating_dialog.dart';
import 'package:flutter/material.dart';
import 'package:visit_egypt/Core/Shared/methods.dart';
import 'package:visit_egypt/Features/Home/Model/place_model.dart';
import 'package:visit_egypt/Features/Home/View/Cubit/home_cubit.dart';

import '../../Model/place_review.dart';

class DisplayRatingDialog extends StatelessWidget {
  final PlaceModel place;
  const DisplayRatingDialog({required this.place, super.key});

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
        commentHint: 'Write your description here',
        title: const Text(""),
        submitButtonText: "Submit",
        onSubmitted: (p0) async {
          var user = FirebaseAuth.instance.currentUser;

          PlaceReview placeReview = PlaceReview(
            description: p0.comment,
            rate: p0.rating,
            reveiwerName: user!.email.toString(),
          );

          BlocProvider.of<HomeCubit>(context, listen: false)
              .addPlaceReview(user.uid, place.placeName, placeReview);
          ConstantMethods.showContentToast(
              context, "Review added successfully!");
        });
  }
}
