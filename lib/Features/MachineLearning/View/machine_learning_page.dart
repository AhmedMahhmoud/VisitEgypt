import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_pickers/image_pickers.dart';
import 'package:visit_egypt/Features/MachineLearning/View/cubit/machine_learning_cubit.dart';

import '../../../Core/Colors/app_colors.dart';

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
        selectCount: 3,
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
    return Scaffold(
      body: BlocBuilder<MachineLearningCubit, MachineLearningState>(
        builder: (context, state) {
          if (state is MachineLearningLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is MachineLearningLoadedState) {
            return Column(
              children: [
                Image(
                  image: FileImage(File(images.first.path!)),
                ),
                Center(
                  child: Text(state.label),
                ),
              ],
            );
          }
          return Center(
              child: MaterialButton(
            shape: const RoundedRectangleBorder(),
            color: Colors.black,
            onPressed: () {
              pickImage();
            },
            child: Center(
                child: Row(
              children: const [
                Text(
                  'Generate Image',
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
            )),
          ));
        },
      ),
    );
  }
}
