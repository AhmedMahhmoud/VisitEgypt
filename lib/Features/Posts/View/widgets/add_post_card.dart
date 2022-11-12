import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../Core/Colors/app_colors.dart';
import 'package:animate_do/animate_do.dart';

import 'add_post_dialog.dart';

class AddPostCard extends StatelessWidget {
  const AddPostCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SlideInDown(
      child: InkWell(
        onTap: () {
          showDialog(
            context: context,
            builder: (context) {
              return PostDialog();
            },
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: SizedBox(
            width: 400.w,
            height: 100.h,
            child: Card(
              shadowColor: CustomColors.lightGold,
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: AbsorbPointer(
                  child: TextField(
                      decoration: InputDecoration(
                          hintText: "Share what is on your mind.",
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                            borderSide: BorderSide(
                              width: 1,
                              style: BorderStyle.none,
                            ),
                          ),
                          suffixIcon: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Card(
                              shadowColor: CustomColors.lightGold,
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              child: Container(
                                margin: const EdgeInsets.all(5),
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.image,
                                  color: CustomColors.greyK,
                                ),
                              ),
                            ),
                          ))),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
