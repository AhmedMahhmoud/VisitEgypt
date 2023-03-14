import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:visit_egypt/Core/Colors/app_colors.dart';
import 'package:visit_egypt/Features/Home/View/widgets/single_location_trip.dart';

class TourGuideHome extends StatefulWidget {
  const TourGuideHome({super.key});

  @override
  State<TourGuideHome> createState() => _TourGuideHomeState();
}

class _TourGuideHomeState extends State<TourGuideHome> {
  int pageIndex = 0;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: 30,
            child: AutoSizeText(
              "Create new trip",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.sp),
            ),
          ),
          const Divider(
            thickness: 1,
            color: CustomColors.greyK,
          ),
          SizedBox(
            height: 5.h,
          ),
          SizedBox(
              child: Container(
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(22),
            ),
            child: DefaultTabController(
              length: 2,
              child: TabBar(
                indicator: BoxDecoration(
                  color: CustomColors.whiteK,
                  borderRadius: BorderRadius.circular(22),
                ),
                labelStyle:
                    TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                labelColor: Colors.black,
                unselectedLabelColor: Colors.white,
                onTap: (value) {
                  setState(() {
                    pageIndex = value;
                  });
                },
                tabs: const [
                  Tab(
                    text: "Single Place",
                  ),
                  Tab(
                    text: "Multiple Places",
                  )
                ],
              ),
            ),
          )),
          SizedBox(
            height: 15.h,
          ),
          TripCreationDisplay(
            pageIndex: pageIndex,
          )
        ],
      ),
    );
  }
}
