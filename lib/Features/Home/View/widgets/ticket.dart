import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:visit_egypt/Core/Styles/text_style.dart';
import 'package:visit_egypt/Features/Home/View/widgets/ticket_details.dart';

class TicketData extends StatelessWidget {
  final String placeName;

  const TicketData({
    Key? key,
    required this.placeName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AutoSizeText(
          '$placeName Ticket',
          style: TextStyle(
              color: Colors.black,
              fontSize: setResponsiveFontSize(16),
              fontWeight: FontWeight.bold),
        ),
        Padding(
          padding: EdgeInsets.only(top: 25.0.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TicketDetailsWidget(
                  firstTitle: 'opening time',
                  firstDesc: '08:00 Am',
                  secondTitle: 'closing time',
                  secondDesc: '7:00 Pm'),
              Padding(
                padding: EdgeInsets.only(top: 12.0.h, right: 40.0.w),
                child: const TicketDetailsWidget(
                    firstTitle: 'Price on vacation',
                    firstDesc: '20 LE',
                    secondTitle: 'Price',
                    secondDesc: '40 LE'),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 45.0.h, left: 30.0.w, right: 30.0.w),
          child: Container(
            width: 250.0,
            height: 40.0,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/barcode.jpg'),
                    fit: BoxFit.cover)),
          ),
        ),
      ],
    );
  }
}
