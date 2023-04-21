import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:visit_egypt/Features/MachineLearning/View/cubit/machine_learning_cubit.dart';

class MlErrorWidget extends StatelessWidget {
  final String errorMsg;
  const MlErrorWidget({
    required this.errorMsg,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Text(errorMsg,
              style: TextStyle(
                fontFamily: 'Changa',
                color: Colors.black,
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              )),
        ),
        SizedBox(
          height: 20.h,
        ),
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
