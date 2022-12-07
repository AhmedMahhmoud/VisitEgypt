import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visit_egypt/Core/Colors/app_colors.dart';
import 'package:visit_egypt/Core/Styles/text_style.dart';
import 'package:visit_egypt/Features/Home/Model/place_review.dart';
import 'package:visit_egypt/Features/Home/View/Cubit/home_cubit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PlacesReviewPage extends StatelessWidget {
  final String placeName;
  const PlacesReviewPage({required this.placeName, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                    'assets/images/bgg.jpg',
                  ),
                  fit: BoxFit.cover,
                  colorFilter:
                      ColorFilter.mode(Colors.white, BlendMode.softLight))),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Material(
                elevation: 25,
                color: Colors.transparent,
                child: AutoSizeText(
                  "Reviews",
                  style: TextStyles.boldStyle
                      .copyWith(fontSize: 25.sp, color: Colors.white),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              FutureBuilder(
                future: BlocProvider.of<HomeCubit>(context, listen: false)
                    .getPlaceReviews(placeName),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Expanded(
                        child: Center(child: CircularProgressIndicator()));
                  } else {
                    List<PlaceReview> reviewsList =
                        snapshot.data as List<PlaceReview>;
                    return reviewsList.isEmpty
                        ? Expanded(
                            child: Center(
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
                            ),
                          )
                        : Expanded(
                            child: ListView.builder(
                              itemCount: reviewsList.length,
                              itemBuilder: (context, index) {
                                return Card(
                                  child: ListTile(
                                    title: AutoSizeText(
                                        reviewsList[index].reveiwerName),
                                    subtitle: AutoSizeText(
                                        reviewsList[index].description),
                                    trailing: SizedBox(
                                      width: 50.w,
                                      height: 50.h,
                                      child: Row(
                                        children: [
                                          Text(reviewsList[index]
                                              .rate
                                              .toString()),
                                          const Icon(
                                            Icons.star,
                                            color: CustomColors.lightGold,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                  }
                },
              )
            ]),
          ),
        ),
      ),
    );
  }
}
