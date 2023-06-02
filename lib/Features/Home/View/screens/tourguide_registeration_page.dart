import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_pickers/image_pickers.dart';
import 'package:visit_egypt/Core/Colors/app_colors.dart';
import 'package:visit_egypt/Core/Constants/constants.dart';
import 'package:visit_egypt/Core/Shared/methods.dart';
import 'package:visit_egypt/Features/Auth/View/cubit/auth_cubit.dart';
import 'package:visit_egypt/Features/Auth/View/login_page.dart';
import 'package:visit_egypt/Features/Home/Model/tourguide_register_model.dart';

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
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  bool isPageLoading = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: CustomColors.lightGold,
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
                          boxShadow: const [
                            BoxShadow(
                                blurRadius: 1,
                                spreadRadius: 1,
                                offset: Offset(0, 2),
                                color: Colors.grey)
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
                                color: images.isNotEmpty
                                    ? Colors.grey
                                    : Colors.grey.withOpacity(0.3))
                          ]),
                      width: 90.w,
                      height: 90.h,
                      child: InkWell(
                        onTap: () {
                          images.isEmpty
                              ? ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                      content: Text(
                                  'Please upload profile picture first !',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                )))
                              : selectImages();
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
                            controller: _userNameController,
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
                            controller: _phoneController,
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
                            child: isPageLoading
                                ? const CircularProgressIndicator.adaptive(
                                    backgroundColor: Colors.white,
                                  )
                                : Text(
                                    'Submit',
                                    style: TextStyle(
                                        color: CustomColors.whiteK,
                                        fontSize: 16.sp),
                                  )),
                      ),
                      onPressed: () async {
                        if (!formKey.currentState!.validate()) {
                          return;
                        } else {
                          if (images.length < 2) {
                            ConstantMethods.showContentToast(
                                context, 'Please fill in the images', true);
                          } else {
                            TourguideRegisterModel tourModel =
                                TourguideRegisterModel(
                                    isAccountActivated: false,
                                    token: await FirebaseMessaging.instance
                                        .getToken(),
                                    phoneNumber: _phoneController.text,
                                    images: [
                                      File(images[0].path!),
                                      File(images[1].path!)
                                    ],
                                    userName: _userNameController.text);
                            setState(() {
                              isPageLoading = true;
                            });
                            bool isUpdated =
                                await BlocProvider.of<AuthCubit>(context)
                                    .updateTourguideData(
                                        FirebaseAuth.instance.currentUser!.uid,
                                        tourModel);
                            setState(() {
                              isPageLoading = false;
                            });
                            if (isUpdated) {
                              // ignore: use_build_context_synchronously
                              ConstantMethods.showContentToast(context,
                                  "Saved successfully , Please wait for admin review");
                              // ignore: use_build_context_synchronously
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const LoginPage(),
                                  ));
                            } else {
                              // ignore: use_build_context_synchronously
                              ConstantMethods.showContentToast(
                                  context,
                                  'Something went wrong , please try again later',
                                  true);
                            }
                          }
                        }
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
