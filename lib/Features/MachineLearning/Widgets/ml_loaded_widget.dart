import 'dart:io';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_pickers/image_pickers.dart';
import 'package:visit_egypt/Features/MachineLearning/View/cubit/machine_learning_cubit.dart';

class MlLoadedWidget extends StatelessWidget {
  final String label;
  final double confidence;
  const MlLoadedWidget({
    required this.confidence,
    required this.label,
    super.key,
    required this.images,
  });

  final List<Media> images;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 10.h,
        ),
        Center(
          child: Text(
            "$label detected successfully !",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.sp),
          ),
        ),
        Text(
          "Accuracy : ${(confidence * 100).toStringAsFixed(2)} %",
          style: TextStyle(fontSize: 15.sp, color: Colors.grey[700]),
        ),
        const Divider(),
        ZoomIn(
          delay: const Duration(milliseconds: 350),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image(
              image: FileImage(File(images.first.path!)),
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
