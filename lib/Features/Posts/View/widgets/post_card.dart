import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:visit_egypt/Features/Posts/View/widgets/user_avatar.dart';

import '../../../../Core/Colors/app_colors.dart';
import '../../../../Core/Styles/text_style.dart';
import '../cubit/posts_cubit.dart';

class PostCardItem extends StatelessWidget {
  const PostCardItem({
    Key? key,
    required this.postsCubit,
    required this.index,
  }) : super(key: key);

  final PostsCubit postsCubit;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
        decoration: BoxDecoration(
            color: Colors.grey[200],
            border: Border.all(color: CustomColors.niceBlue, width: 0.5.w),
            borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const UserAvatar(username: 'U'),
                      SizedBox(
                        width: 8.w,
                      ),
                      AutoSizeText(
                        'username',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: setResponsiveFontSize(18),
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.start,
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 8.w,
                  ),  Padding(
                    padding:  EdgeInsets.only(right: 8.w,top: 8.h,bottom: 8.h,left: 10.w),
                    child: AutoSizeText(
                      postsCubit.retrievedPosts[index].postContent,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: setResponsiveFontSize(16)),
                      textAlign: TextAlign.start,
                    ),
                  ),

                ],
              ),
              postsCubit.retrievedPosts[index].retrievedPostImages!.isNotEmpty
                  ? SizedBox(
                      height: 200.h,
                      child: ListView.builder(
                        itemCount: postsCubit
                            .retrievedPosts[index].retrievedPostImages!.length,
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemBuilder: (context, i) {
                          return SizedBox(
                            width: 200.w,
                            child: Card(
                              child: InkWell(
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return Dialog(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                          elevation: 16,
                                          child: SizedBox(
                                            height: 400.h,
                                            width: double.infinity,
                                            child: CachedNetworkImage(
                                              imageUrl: postsCubit
                                                  .retrievedPosts[index]
                                                  .retrievedPostImages![i],
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        );
                                      });
                                },
                                child: CachedNetworkImage(
                                  imageUrl: postsCubit.retrievedPosts[index]
                                      .retrievedPostImages![i],
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  : Container()
            ],
          ),
        ));
  }
}
