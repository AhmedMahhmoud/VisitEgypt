import 'dart:developer';
import 'dart:io';

import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../Core/Colors/app_colors.dart';
import 'package:animate_do/animate_do.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:image_pickers/image_pickers.dart';
import '../../../../Core/Shared/methods.dart';
import '../../../../Core/Styles/text_style.dart';
import '../../Model/posts_model.dart';
import '../cubit/posts_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class PostDialog extends StatelessWidget {
  List<Media> images = [];
  final TextEditingController _postsEditingController = TextEditingController();
  Future<void> selectImages(update) async {
    List<Media> listImagePaths = await ImagePickers.pickerPaths(
        galleryMode: GalleryMode.image,
        selectCount: 3,
        showGif: false,
        showCamera: true,
        compressSize: 500,
        uiConfig: UIConfig(uiThemeColor: CustomColors.niceBlue),
        cropConfig: CropConfig(enableCrop: false, width: 2, height: 1));
    if (listImagePaths.isNotEmpty) {
      update(() {
        images = listImagePaths;
      });
    }
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return SlideInDown(
        duration: const Duration(seconds: 1),
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              child: BlocListener<PostsCubit, PostsState>(
                listener: (ctx, state) {
                  log(state.toString());
                  if (state is PostsErrorState) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(state.errorMsg)));
                  } else if (state is PostsLoadedState) {
                    ConstantMethods.showContentToast(
                        context, "Post uploaded successfully !");
                    Navigator.pop(context);
                  }
                },
                child: TweenAnimationBuilder<double>(
                    tween: Tween(
                      begin: 0,
                      end: 1,
                    ),
                    curve: Curves.linear,
                    duration: const Duration(milliseconds: 800),
                    builder: (context, value, child) {
                      return Opacity(
                        opacity: value,
                        child: StatefulBuilder(builder: (context, updateState) {
                          return SizedBox(
                              width: double.infinity,
                              height: 600.h,
                              child: BlocBuilder<PostsCubit, PostsState>(
                                  builder: (context, state) {
                                if (state is PostsLoadingState) {
                                  return Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Center(
                                        child: DefaultTextStyle(
                                          textAlign: TextAlign.center,
                                          style: TextStyles.boldStyle.copyWith(
                                              color: CustomColors.greyK
                                                  .withOpacity(0.7),
                                              fontSize: 17),
                                          child: AnimatedTextKit(
                                            repeatForever: false,
                                            totalRepeatCount: 1,
                                            animatedTexts: [
                                              TyperAnimatedText(
                                                  speed: const Duration(
                                                      milliseconds: 100),
                                                  'Your post is uploading now ...'),
                                              TyperAnimatedText(
                                                  speed: const Duration(
                                                      milliseconds: 100),
                                                  'Please wait ...'),
                                              TyperAnimatedText(
                                                  speed: const Duration(
                                                      milliseconds: 100),
                                                  'Almost  done ...'),
                                            ],
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      const Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                    ],
                                  );
                                } else {
                                  return Column(
                                    children: [
                                      Expanded(
                                        child: ListView(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(15.0),
                                              child: Column(children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Expanded(
                                                        child: Container()),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 20.w),
                                                      child: ElevatedButton(
                                                        style: ButtonStyle(
                                                            backgroundColor:
                                                                MaterialStateProperty.all(
                                                                    CustomColors
                                                                        .greyK
                                                                        .withOpacity(
                                                                            0.5))),
                                                        onPressed:
                                                            _postsEditingController
                                                                    .text
                                                                    .isEmpty
                                                                ? () {
                                                                    ConstantMethods.showContentToast(
                                                                        context,
                                                                        "Please add some content first",
                                                                        true);
                                                                  }
                                                                : () async {
                                                                    List<File>
                                                                        imageFiles =
                                                                        [];
                                                                    if (images
                                                                        .isNotEmpty) {
                                                                      for (var i
                                                                          in images) {
                                                                        imageFiles
                                                                            .add(File(i.path!));
                                                                      }
                                                                    }
                                                                    final Posts post = Posts(
                                                                        postImages:
                                                                            imageFiles,
                                                                        postContent:
                                                                            _postsEditingController
                                                                                .text,
                                                                        userID: FirebaseAuth
                                                                            .instance
                                                                            .currentUser!
                                                                            .uid);
                                                                    await context
                                                                        .read<
                                                                            PostsCubit>()
                                                                        .uploadPostImages(
                                                                            post);
                                                                  },
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(3.0),
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceEvenly,
                                                            children: [
                                                              Text(
                                                                "Post now",
                                                                style: TextStyles
                                                                    .boldStyle
                                                                    .copyWith(
                                                                        fontSize:
                                                                            setResponsiveFontSize(18)),
                                                              ),
                                                              const Icon(Icons
                                                                  .save_alt_rounded)
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                        child: Container()),
                                                    InkWell(
                                                      onTap: () =>
                                                          Navigator.pop(
                                                              context),
                                                      child: const Icon(
                                                        Icons.close,
                                                        color: CustomColors
                                                            .errorColor,
                                                        size: 30,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                const Divider(
                                                  thickness: 1,
                                                  color: CustomColors.greyK,
                                                ),
                                                TextField(
                                                    controller:
                                                        _postsEditingController,
                                                    maxLines: null,
                                                    decoration:
                                                        const InputDecoration(
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                          Radius.circular(10.0),
                                                        ),
                                                        borderSide: BorderSide(
                                                            width: 1,
                                                            style: BorderStyle
                                                                .solid,
                                                            color: CustomColors
                                                                .greyK),
                                                      ),
                                                      hintText:
                                                          "Share what is on your mind.",
                                                      border:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                          Radius.circular(10.0),
                                                        ),
                                                        borderSide: BorderSide(
                                                          width: 1,
                                                          style:
                                                              BorderStyle.solid,
                                                        ),
                                                      ),
                                                    ))
                                              ]),
                                            ),
                                          ],
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          selectImages(updateState);
                                        },
                                        child: Container(
                                          width: double.infinity,
                                          color: CustomColors.greyK
                                              .withOpacity(0.7),
                                          child: images.isNotEmpty
                                              ? SizedBox(
                                                  height: 100.h,
                                                  child: Wrap(
                                                      alignment:
                                                          WrapAlignment.center,
                                                      direction:
                                                          Axis.horizontal,
                                                      children: images
                                                          .map((e) => Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        top:
                                                                            10),
                                                                child: FadeIn(
                                                                  duration:
                                                                      const Duration(
                                                                          seconds:
                                                                              1),
                                                                  child: SizedBox(
                                                                      width: 80.w,
                                                                      height: 80.h,
                                                                      child: CircleAvatar(
                                                                        backgroundColor:
                                                                            Colors.white,
                                                                        backgroundImage:
                                                                            FileImage(
                                                                          File(
                                                                            e.path!,
                                                                          ),
                                                                        ),
                                                                      )),
                                                                ),
                                                              ))
                                                          .toList()),
                                                )
                                              : Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    const Divider(
                                                      color: CustomColors.greyK,
                                                    ),
                                                    SizedBox(
                                                      width: double.infinity,
                                                      height: 100.h,
                                                      child: ListView(
                                                        children: [
                                                          CircleAvatar(
                                                            backgroundColor:
                                                                CustomColors
                                                                    .greyK
                                                                    .withOpacity(
                                                                        0.8),
                                                            child: const Icon(Icons
                                                                .photo_size_select_actual_rounded),
                                                          ),
                                                          const SizedBox(
                                                            height: 5,
                                                          ),
                                                          Center(
                                                            child: AutoSizeText(
                                                              "Add photos to your post",
                                                              style: TextStyles
                                                                  .normalStyle
                                                                  .copyWith(),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                        ),
                                      )
                                    ],
                                  );
                                }
                              }));
                        }),
                      );
                    }),
              )),
        ));
  }
}
