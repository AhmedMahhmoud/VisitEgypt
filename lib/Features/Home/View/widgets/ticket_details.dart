import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TicketDetailsWidget extends StatelessWidget {
  final String firstTitle;
  final String firstDesc;
  final String secondTitle;
  final String secondDesc;
  const TicketDetailsWidget({
    Key? key,
    required this.firstTitle,
    required this.firstDesc,
    required this.secondTitle,
    required this.secondDesc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 12.0.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              AutoSizeText(
                firstTitle,
                style: const TextStyle(color: Colors.grey),
              ),
              Padding(
                padding: EdgeInsets.only(top: 4.0.h),
                child: AutoSizeText(
                  firstDesc,
                  style: const TextStyle(color: Colors.black),
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: 20.0.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AutoSizeText(
                secondTitle,
                style: const TextStyle(color: Colors.grey),
              ),
              Padding(
                padding: EdgeInsets.only(top: 4.0.h),
                child: AutoSizeText(
                  secondDesc,
                  style: const TextStyle(color: Colors.black),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
