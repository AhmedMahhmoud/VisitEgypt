import 'dart:io';

import 'package:flutter/material.dart';

import '../../../../Core/Colors/app_colors.dart';
import '../../../../Core/Styles/text_style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:image_pickers/image_pickers.dart';
import 'package:animate_do/animate_do.dart';

class AddPostImagesButton extends StatefulWidget {
  final Function getImages;
  const AddPostImagesButton({required this.getImages, super.key});

  @override
  State<AddPostImagesButton> createState() => _AddPostImagesButtonState();
}

class _AddPostImagesButtonState extends State<AddPostImagesButton> {
  List<Media> images = [];
  Future<void> selectImages() async {
    List<Media> listImagePaths = await ImagePickers.pickerPaths(
        galleryMode: GalleryMode.image,
        selectCount: 3,
        showGif: false,
        showCamera: true,
        compressSize: 500,
        uiConfig: UIConfig(uiThemeColor: CustomColors.niceBlue),
        cropConfig: CropConfig(enableCrop: false, width: 2, height: 1));
    if (listImagePaths.isNotEmpty) {
      images = listImagePaths;
      widget.getImages(images);
      setState(() {});
    }
  }

  clearImages() {
    images.clear();
    widget.getImages(images);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: InkWell(
        onTap: () => selectImages(),
        child: images.isNotEmpty
            ? Stack(
                children: [
                  SizedBox(
                    height: 100.h,
                    child: Column(
                      children: [
                        const Divider(
                          color: CustomColors.greyK,
                          thickness: 1,
                        ),
                        Wrap(
                            spacing: 20,
                            alignment: WrapAlignment.center,
                            direction: Axis.horizontal,
                            children: images
                                .map((e) => FadeIn(
                                      duration: const Duration(seconds: 1),
                                      child: SizedBox(
                                          width: 80.w,
                                          height: 80.h,
                                          child: CircleAvatar(
                                            backgroundColor: Colors.white,
                                            backgroundImage: FileImage(
                                              File(
                                                e.path!,
                                              ),
                                            ),
                                          )),
                                    ))
                                .toList()),
                      ],
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.all(10),
                      child: IconButton(
                        onPressed: () {
                          clearImages();
                        },
                        icon: const Icon(
                          (Icons.cancel),
                        ),
                      ))
                ],
              )
            : Column(
                children: [
                  const Divider(
                    color: CustomColors.greyK,
                    thickness: 1,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 20.h,
                  ),
                  CircleAvatar(
                    backgroundColor: CustomColors.greyK.withOpacity(0.8),
                    child: const Icon(Icons.photo_size_select_actual_rounded),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Center(
                    child: AutoSizeText(
                      "Add photos to your post",
                      style: TextStyles.normalStyle.copyWith(),
                    ),
                  )
                ],
              ),
      ),
    );
  }
}
