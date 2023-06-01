import 'dart:io';
import '../../../../Core/Constants/constants.dart';

import 'package:animate_do/animate_do.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_pickers/image_pickers.dart';
import 'package:readmore/readmore.dart';
import 'package:visit_egypt/Features/MachineLearning/View/cubit/machine_learning_cubit.dart';
import 'package:visit_egypt/Features/MachineLearning/Widgets/predicted_place_map_display.dart';

import '../../../Core/Colors/app_colors.dart';
import '../../../Core/Styles/text_style.dart';
import '../../Home/View/widgets/place_location_map_display.dart';
import '../Model/predicted_place.dart';

class MlLoadedWidget extends StatelessWidget {
  final String label;
  final double confidence;
  final PredictedPlace predictedPlace;
  const MlLoadedWidget({
    required this.confidence,
    required this.predictedPlace,
    required this.label,
    super.key,
    required this.images,
  });

  final List<Media> images;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /*       SizedBox(
          height: 10.h,
        ),

        Text(
          "Accuracy : ${(confidence * 100).toStringAsFixed(2)} %",
          style: TextStyle(fontSize: 15.sp, color: Colors.grey[700]),
        ),
        const Divider(),*/
        ZoomIn(
          delay: const Duration(milliseconds: 350),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.3,
            width: MediaQuery.of(context).size.width,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20)),
              child: Image(
                image: FileImage(
                  File(
                    images.first.path!,
                  ),
                ),
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
        Center(
          child: Text(
            predictedPlace.placeName,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.sp),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            height: 320.h,
            child: Card(
              color: Colors.white,
              elevation: 4,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: ListView(
                children: [
                  Padding(
                      padding: EdgeInsets.all(
                        10.w,
                      ),
                      child: ReadMoreText(
                        predictedPlace.placeDescription,
                        trimLines: 3,
                        trimMode: TrimMode.Line,
                        lessStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: CustomColors.lightGold,
                          fontSize: setResponsiveFontSize(14),
                        ),
                        trimCollapsedText: 'Show more',
                        trimExpandedText: 'Show less',
                        moreStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: CustomColors.lightGold,
                          fontSize: setResponsiveFontSize(14),
                        ),
                      )),
                  SizedBox(
                    height: 10.h,
                  ),
                  PredictedPlaceMapDisplay(
                    predictedPlace: predictedPlace,
                  ),
                  SizedBox(
                    height: 50.h,
                  ),
                ],
              ),
            ),
          ),
        ),
        const Spacer(),
        FadeIn(
          delay: const Duration(milliseconds: 800),
          child: Center(
              child: SizedBox(
            width: 200.w,
            child: MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              color: Colors.black,
              onPressed: () {
                BlocProvider.of<MachineLearningCubit>(context).resetState();
              },
              child: const Center(
                  child: Text(
                'Retry',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              )),
            ),
          )),
        ),
      ],
    );
  }
}
