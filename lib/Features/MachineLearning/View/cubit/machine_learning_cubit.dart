import 'dart:io';
import 'package:tflite/tflite.dart';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
part 'machine_learning_state.dart';

class MachineLearningCubit extends Cubit<MachineLearningState> {
  MachineLearningCubit() : super(MachineLearningInitial());
  loadModel() async {
    await Tflite.loadModel(
            model: 'assets/model_unquant.tflite', labels: 'assets/labels.txt')
        .then((value) => print(value));
    print('Model loaded successfully');
  }

  classifyImage(File image) async {
    emit(MachineLearningLoadingState());
    var output = await Tflite.runModelOnImage(
        path: image.path,
        numResults: 2,
        threshold: 0.5,
        imageMean: 127.5,
        imageStd: 127.5);
    emit(MachineLearningLoadedState(
        label: "${output![0]['label']}".replaceAll(RegExp(r'[0-9]'), '')));
  }
}
