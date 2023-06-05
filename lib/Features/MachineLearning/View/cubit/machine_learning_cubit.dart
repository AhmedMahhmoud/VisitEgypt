import 'dart:io';
import 'dart:developer';
import 'package:tflite/tflite.dart';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../Core/Constants/constants.dart';
import '../../Model/predicted_place.dart';
part 'machine_learning_state.dart';

class MachineLearningCubit extends Cubit<MachineLearningState> {
  MachineLearningCubit() : super(MachineLearningInitial());
  loadModel() async {
    await Tflite.loadModel(
            model: 'assets/model_unquant.tflite', labels: 'assets/labels.txt')
        .then((value) => print(value));
  }

  resetState() {
    emit(MachineLearningInitial());
  }

  classifyImage(File image) async {
    emit(MachineLearningLoadingState());
    try {
      var output = await Tflite.runModelOnImage(
          path: image.path,
          numResults: 2,
          threshold: 0.5,
          imageMean: 127.5,
          imageStd: 127.5);
      log(output.toString());
      inspect(output);
      if (output![0]['confidence'] > 0.7) {
        emit(MachineLearningLoadedState(
            label: "${output[0]['label']}".replaceAll(RegExp(r'[0-9]'), ''),
            confidence: output[0]['confidence'],
            predictedPlace: getPredictedPlace(
                "${output[0]['label']}".replaceAll(RegExp(r'[0-9]'), ''))));
      } else {
        emit(const MachineLearningErrorState(
            errorMsg: 'Couldnt find a match !'));
      }
    } catch (e) {
      emit(const MachineLearningErrorState(
          errorMsg: 'Error classifying image , Please try another'));
    }
  }

  PredictedPlace getPredictedPlace(String label) {
    PredictedPlace predictedPlace;
    print(label);
    switch (label.trim()) {
      case 'Cairo tower':
        predictedPlace = Constants.allPredictedPlaces[2];
        break;
      case 'Pyramids':
        predictedPlace = Constants.allPredictedPlaces[3];
        break;
      case 'Sphenix':
        predictedPlace = Constants.allPredictedPlaces[0];
        break;
      case 'Abu simbel':
        predictedPlace = Constants.allPredictedPlaces[1];
        break;
      case 'Toot':
        predictedPlace = Constants.allPredictedPlaces[4];
        break;
      default:
        predictedPlace = Constants.allPredictedPlaces[4];
        break;
    }

    return predictedPlace;
  }
}
