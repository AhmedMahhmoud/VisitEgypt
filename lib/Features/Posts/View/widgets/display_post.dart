import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:visit_egypt/Features/Posts/Model/posts_model.dart';

import '../widgets/post_card.dart';

class DisplayPostsList extends StatelessWidget {
  const DisplayPostsList({
    Key? key,
    required this.posts,
  }) : super(key: key);

  final List<Posts> posts;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: posts.length,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return PostCardItem(
          posts: posts[index],
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: const Divider(
            thickness: 2,
          ),
        );
      },
    );
  }
}
