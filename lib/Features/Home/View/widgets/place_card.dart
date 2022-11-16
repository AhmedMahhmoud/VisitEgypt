import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


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
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 20.w,
        vertical: 10.h,
      ),
      // color: Colors.blueAccent,
      height: 160.h,
      child: InkWell(
        //  onTap: press,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            // Those are our background
            Container(
              height: 140.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22),
                color: itemIndex.isEven
                    ? CustomColors.lightGold
                    : Colors.black.withOpacity(0.8),
                boxShadow: const [Constants.kDefaultShadow],
              ),
              child: Container(
                margin: EdgeInsets.only(right: 10.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(22),
                ),
              ),
            ),
            // our product image
            Positioned(
              top: 0,
              right: 0,
              child: Hero(
                tag: '${place.placeId}',
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  height: 160.h,
                  // image is square but we add extra 20 + 20 padding thats why width is 200
                  width: 160.w,
                  child: Image.asset(
                    place.placeImage,
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
            ),

            Positioned(
              bottom: 0,
              left: 0,
              child: SizedBox(
                height: 128.h,
                // our image take 200 width, thats why we set out total width - 200
                width: size.width - 200.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    //  const Spacer(),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Text(
                        place.placeName,
                        maxLines: 2,
                        style: Theme.of(context).textTheme.button,
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                      child: Text(
                        place.placeDescription,
                        maxLines: 4,overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontWeight: FontWeight.w400,color: Colors.black.withOpacity(0.5)),
                      ),
                    ),
                    const Spacer(),


                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 5.h, // 5 top and bottom
                      ),
                      width: 75.w,
                      decoration:  BoxDecoration(
                        color: Colors.black.withOpacity(0.8),
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(22),
                          topRight: Radius.circular(22),
                        ),
                      ),
                      child: Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 4.w),
                        child: Row(

                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              place.placeRate.toString(), maxLines: 1,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, color: CustomColors.lightGold),
                              // style: Theme.of(context).textTheme.button,
                            ),
                            const Icon(Icons.star,color: CustomColors.lightGold,)
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
