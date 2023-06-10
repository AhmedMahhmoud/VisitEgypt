import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_pickers/image_pickers.dart';
import 'package:lottie/lottie.dart';
import 'package:visit_egypt/Enums/firebase_request_enum.dart';
import 'package:visit_egypt/Features/MachineLearning/View/cubit/machine_learning_cubit.dart';
import 'package:visit_egypt/Features/bottom_navigation/bottom_navigation.dart';

import '../../../Core/Colors/app_colors.dart';
import '../Widgets/ml_error_widget.dart';
import '../Widgets/ml_loaded_widget.dart';

class MachineLearningPage extends StatefulWidget {
  const MachineLearningPage({super.key});

  @override
  State<MachineLearningPage> createState() => _MachineLearningPageState();
}

class _MachineLearningPageState extends State<MachineLearningPage> {
  List<Media> images = [];
  pickImage() async {
    List<Media> listImagePaths = await ImagePickers.pickerPaths(
        galleryMode: GalleryMode.image,
        selectCount: 1,
        showGif: false,
        showCamera: true,
        compressSize: 500,
        uiConfig: UIConfig(uiThemeColor: CustomColors.niceBlue),
        cropConfig: CropConfig(enableCrop: false, width: 2, height: 1));
    if (listImagePaths.isNotEmpty) {
      setState(() {
        images = listImagePaths;
      });
      // ignore: use_build_context_synchronously
      BlocProvider.of<MachineLearningCubit>(context)
          .classifyImage(File(images.first.path!));
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        BlocProvider.of<MachineLearningCubit>(context).resetState();
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => BottomNav(
                  comingIndex: 2,
                  firebaseRequestType: FirebaseRequestType.login),
            ));
        throw '';
      },
      child: Scaffold(
        backgroundColor: CustomColors.lightGold,
        body: SafeArea(
          child: BlocBuilder<MachineLearningCubit, MachineLearningState>(
            builder: (context, state) {
              if (state is MachineLearningLoadingState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is MachineLearningErrorState) {
                return MlErrorWidget(
                  errorMsg: state.errorMsg,
                );
              } else if (state is MachineLearningLoadedState) {
                return MlLoadedWidget(
                  images: images,
                  label: state.label,
                  predictedPlace: state.predictedPlace,
                );
              }
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Please add a historical image to be detected',
                    style: TextStyle(
                        fontFamily: 'Changa',
                        color: Colors.black,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 200.w,
                    height: 200.h,
                    child: Lottie.asset('assets/lotties/imageDetect.json'),
                  ),
                  Center(
                      child: SizedBox(
                    width: 170.w,
                    child: MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      color: Colors.black,
                      onPressed: () {
                        pickImage();
                      },
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Upload Image',
                            style: TextStyle(color: Colors.white),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Icon(
                            Icons.image,
                            color: Colors.white,
                          )
                        ],
                      ),
                    ),
                  )),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
