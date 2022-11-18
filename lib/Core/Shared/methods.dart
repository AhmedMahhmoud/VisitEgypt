import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

import '../Colors/app_colors.dart';

class ConstantMethods {
  static showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      backgroundColor: Colors.transparent,
      content: Center(
          child: Container(
        color: Colors.transparent,
        height: 120.h,
        child: Lottie.asset('assets/lotties/eyes.json'),
      )),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  static showContentToast(BuildContext context, String content,
      [bool isError = false]) {
    return showToast(content,
        context: context,
        animation: StyledToastAnimation.slideFromTop,
        duration: const Duration(seconds: 3),
        position: StyledToastPosition.center,
        curve: Curves.linear,
        backgroundColor:
            isError ? CustomColors.errorColor : CustomColors.successColor,
        reverseCurve: Curves.linear);
  }
}
