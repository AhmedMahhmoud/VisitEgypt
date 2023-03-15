import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_pickers/image_pickers.dart';
import 'package:visit_egypt/Core/Colors/app_colors.dart';
import 'package:visit_egypt/Core/Constants/constants.dart';

class TourguideRegisterationPage extends StatefulWidget {
  const TourguideRegisterationPage({super.key});

  @override
  State<TourguideRegisterationPage> createState() =>
      _TourguideRegisterationPageState();
}

class _TourguideRegisterationPageState
    extends State<TourguideRegisterationPage> {
  List<Media> images = [];
  Future<void> selectImages() async {
    List<Media> listImagePaths = await ImagePickers.pickerPaths(
        galleryMode: GalleryMode.image,
        selectCount: 1,
        showGif: false,
        showCamera: true,
        compressSize: 500,
        uiConfig: UIConfig(uiThemeColor: CustomColors.niceBlue),
        cropConfig: CropConfig(enableCrop: false, width: 2, height: 1));
    if (listImagePaths.isNotEmpty) {
      if (images.isNotEmpty) {
        images.add(listImagePaths.first);
      } else {
        images = listImagePaths;
      }

      setState(() {});
    }
  }

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: CustomColors.niceOrange,
        body: Form(
          key: formKey,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 10.h,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: AutoSizeText(
                      "Enter your profile picture",
                      style: TextStyle(
                          fontSize: 15.sp, color: CustomColors.blackK),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Center(
                    child: Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border:
                              Border.all(width: 2, color: CustomColors.whiteK),
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 1,
                                spreadRadius: 1,
                                offset: const Offset(0, 2),
                                color: Colors.grey.withOpacity(0.3))
                          ]),
                      width: 90.w,
                      height: 90.h,
                      child: InkWell(
                        onTap: () {
                          selectImages();
                        },
                        child: images.isEmpty
                            ? const Center(
                                child: Icon(
                                  Icons.camera_alt,
                                  color: CustomColors.whiteK,
                                ),
                              )
                            : ClipOval(
                                child: Image.file(
                                  File(images.first.path!),
                                  fit: BoxFit.fill,
                                ),
                              ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: AutoSizeText(
                      "Attach college degree picture",
                      style: TextStyle(
                          fontSize: 15.sp, color: CustomColors.blackK),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Center(
                    child: Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border:
                              Border.all(width: 2, color: CustomColors.whiteK),
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 1,
                                spreadRadius: 1,
                                offset: const Offset(0, 2),
                                color: Colors.grey.withOpacity(0.3))
                          ]),
                      width: 90.w,
                      height: 90.h,
                      child: InkWell(
                        onTap: () {
                          selectImages();
                        },
                        child: images.length < 2
                            ? const Center(
                                child: Icon(
                                  Icons.camera_alt,
                                  color: CustomColors.whiteK,
                                ),
                              )
                            : ClipOval(
                                child: Image.file(
                                  File(images[1].path!),
                                  fit: BoxFit.fill,
                                ),
                              ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const AutoSizeText('Please fill the following'),
                        const SizedBox(
                          height: 5,
                        ),
                        SizedBox(
                          child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Required';
                              }
                              return null;
                            },
                            decoration: textFieldDecoration.copyWith(
                                hintText: 'Name',
                                contentPadding: const EdgeInsets.all(5)),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Required';
                              } else if (value.length < 11) {
                                return 'Enter a valid number';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.phone,
                            maxLength: 11,
                            decoration: textFieldDecoration.copyWith(
                                hintText: 'Phone',
                                contentPadding: const EdgeInsets.all(5)),
                          ),
                        )
                      ],
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: EdgeInsets.only(bottom: 20.h),
                    child: MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      color: CustomColors.greyK,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                            child: Text(
                          'Submit',
                          style: TextStyle(
                              color: CustomColors.whiteK, fontSize: 16.sp),
                        )),
                      ),
                      onPressed: () {
                        if (!formKey.currentState!.validate()) {
                          return;
                        } else {}
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
