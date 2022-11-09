import 'package:task/Core/Constants/constants.dart';

import '../Model/place_model.dart';

abstract class HomeRepository {
  List<PlaceModel> getAllPlaces();

  List<PlaceModel> searchInPlaces(String placeName);
}

class HomeRepositoryImp implements HomeRepository {
  @override
  List<PlaceModel> getAllPlaces() {
    return Constants.allPlaces;
  }

  @override
  List<PlaceModel> searchInPlaces(String placeName) {
    List<PlaceModel> results = [];
    if (placeName.isEmpty) {
      return Constants.allPlaces;
    } else {
      results = Constants.allPlaces
          .where((place) =>
              place.placeName.toLowerCase().contains(placeName.toLowerCase()))
          .toList();
    }
    return results;
  }
}
