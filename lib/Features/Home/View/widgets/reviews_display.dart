import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:visit_egypt/Features/Home/Model/place_model.dart';
import 'package:visit_egypt/Features/Home/View/screens/places_reviews.dart';
import '../../../../Core/Colors/app_colors.dart';
import '../../../../Core/Styles/text_style.dart';
import '../../Model/place_review.dart';
import '../Cubit/home_cubit.dart';
import '../widgets/rating_dialog.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReviewsDisplay extends StatefulWidget {
  const ReviewsDisplay({
    Key? key,
    required this.placeModel,
  }) : super(key: key);

  final PlaceModel placeModel;

  @override
  State<ReviewsDisplay> createState() => _ReviewsDisplayState();
}

class _ReviewsDisplayState extends State<ReviewsDisplay> {
  late Future loadRatings;
  List<PlaceReview> reviews = [];
  loadRates() async {
    loadRatings = BlocProvider.of<HomeCubit>(context, listen: false)
        .getPlaceReviews(widget.placeModel.placeName);
  }

  @override
  void initState() {
    loadRates();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AutoSizeText(
            "Reviews",
            style: TextStyles.boldStyle.copyWith(fontFamily: 'Changa'),
          ),
          InkWell(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (context) => GestureDetector(
                        onTap: () {
                          FocusScope.of(context).unfocus();
                        },
                        child: Column(
                          children: [
                            DisplayRatingDialog(
                              place: widget.placeModel,
                              refreshReviewsFuture: () {
                                loadRates();
                                setState(() {});
                              },
                            ),
                          ],
                        ),
                      ));
            },
            child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              AutoSizeText(
                widget.placeModel.placeRate.toString(),
                maxLines: 1,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: setResponsiveFontSize(14),
                    color: CustomColors.lightGold),
                // style: Theme.of(context).textTheme.button,
              ),
              Icon(
                Icons.star,
                color: CustomColors.lightGold,
                size: 22.w,
              ),
              Expanded(child: Container()),
              InkWell(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PlacesReviewPage(
                        reviewsList: reviews,
                      ),
                    )),
                child: AutoSizeText(
                  "View all reviews",
                  style: TextStyles.boldStyle.copyWith(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.bold,
                      color: CustomColors.lightGold,
                      decoration: TextDecoration.underline),
                ),
              ),
            ]),
          ),
          SizedBox(
            width: 500,
            height: 130.h,
            child: FutureBuilder(
              future: loadRatings,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  List<PlaceReview> reviewsList =
                      snapshot.data as List<PlaceReview>;
                  reviews = reviewsList;
                  return reviewsList.isEmpty
                      ? Center(
                          child: Card(
                            elevation: 5,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "There are no reviews for this place yet",
                                style: TextStyles.boldStyle,
                              ),
                            ),
                          ),
                        )
                      : SizedBox(
                          child: ListView.separated(
                            separatorBuilder: (context, index) =>
                                const VerticalDivider(),
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return Card(
                                elevation: 5,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      AutoSizeText(
                                        reviewsList[index].reveiwerName,
                                        style: TextStyles.boldStyle.copyWith(
                                            color: CustomColors.greyK,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 13.sp),
                                      ),
                                      Row(
                                        children: [
                                          Text(reviewsList[index]
                                              .rate
                                              .toString()),
                                          const Icon(
                                            Icons.star,
                                            color: CustomColors.lightGold,
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      SizedBox(
                                          width: 180.w,
                                          child: AutoSizeText(
                                              reviewsList[index].description))
                                    ],
                                  ),
                                ),
                              );
                            },
                            itemCount: reviewsList.length,
                          ),
                        );
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
