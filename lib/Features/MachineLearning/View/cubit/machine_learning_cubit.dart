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
        model: 'assets/model_unquant.tflite', labels: 'assets/labels.txt');
  }

  resetState() {
    emit(MachineLearningInitial());
  }

  classifyImage(File image) async {
    emit(MachineLearningLoadingState());
    try {
      var output = await Tflite.runModelOnImage(
          path: image.path,
          numResults:
              1, //This parameter specifies the maximum number of results that should be returned by the model For example, if numResults is set to 2, the model will return the top 2
          threshold:
              0.5, //This parameter specifies the minimum confidence threshold (min accuracy res)
          imageMean:
              127.5, //mean value that should be subtracted from each pixel in the image before it is processed by the model. This is a normalization step that helps the model work better with different types of images.
          imageStd:
              127.5); //standard deviation value that should be divided by each pixel in the image before it is processed by the model. This is another normalization step
      log(output.toString());
      if (output![0]['confidence'] > 0.8) {
        emit(MachineLearningLoadedState(
            label: "${output[0]['label']}".replaceAll(RegExp(r'[0-9]'), ''),
            // confidence: output[0]['confidence'],
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
