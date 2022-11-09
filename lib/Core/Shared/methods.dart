import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';

showLoaderDialog(BuildContext context) {
  AlertDialog alert = AlertDialog(backgroundColor: Colors.transparent,
    content: Center(child: Container(
      color: Colors.transparent,
      height: 120.h,
      child: Lottie.asset('assets/lotties/eyes.json'),)),
  );
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
