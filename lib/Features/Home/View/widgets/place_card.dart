import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:visit_egypt/Core/Styles/text_style.dart';

import '../../../../Core/Colors/app_colors.dart';
import '../../../../Core/Constants/constants.dart';
import '../../Model/place_model.dart';

class PlaceCard extends StatelessWidget {
  const PlaceCard({
    Key? key,
    required this.itemIndex,
    required this.place,
    required this.press,
  }) : super(key: key);

  final int itemIndex;
  final PlaceModel place;
  final Function press;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      //  onTap: press,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            // Those are our background
            Container(
              height: 165.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22),
                color: itemIndex.isEven
                    ? CustomColors.lightGold
                    : Colors.black.withOpacity(0.8),
                boxShadow: const [Constants.kDefaultShadow],
              ),
              child: Container(
                margin: EdgeInsets.only(right: 12.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(
                    image: AssetImage(
                      place.placeImage,
                    ),
                    fit: BoxFit.fill,
                    colorFilter: const ColorFilter.mode(
                        Colors.white, BlendMode.softLight),
                  ),
                  borderRadius: BorderRadius.circular(22),
                ),
              ),
            ),

            Positioned(top: 8.h, right: 16.w, child: Container(
             // height: 30.h,width: 60.w,
              child: Padding(
                padding:  EdgeInsets.symmetric(horizontal: 6.w),
                child:                            Text(
                  place.placeName,
                  maxLines: 2,
                  style: TextStyle(
                      fontFamily: 'Changa',
                      color: Colors.black38,
                      //      fontSize: setResponsiveFontSize(16),
                      fontWeight: FontWeight.bold),
                ),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),color: Colors.white,boxShadow: const [Constants.kDefaultShadow]
              ),
            )),
            Positioned(
              bottom: 0.h,
              left: 0.w,
              child: SizedBox(
                height: 130.h,
                width: size.width - 200.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Spacer(),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 5.h, // 5 top and bottom
                      ),
                      width: 75.w,
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.7),
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(22),
                          topRight: Radius.circular(22),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 4.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                place.placeRate.toString(), maxLines: 1,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: CustomColors.lightGold),
                                // style: Theme.of(context).textTheme.button,
                              ),
                               Icon(
                                Icons.star,
                                color: CustomColors.lightGold,   size: 22.w,
                              )
                            ]),
                         /*   Padding(
                              padding: EdgeInsets.only(bottom: 4.h),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.location_on_sharp,
                                    size: 16.w,
                                    color: CustomColors.lightGold,
                                  ),
                                  AutoSizeText(
                                    place.cityOfPlace,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: CustomColors.lightGold),
                                  ),
                                ],
                              ),
                            ),*/
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
