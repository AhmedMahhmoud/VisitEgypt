import 'package:task/Core/Constants/constants.dart';
import 'package:task/Services/Geolocator/geolocator.dart';
import '../Model/place_model.dart';

abstract class HomeRepository {
  Future<List<PlaceModel>> getAllPlaces();

  List<PlaceModel> searchInPlaces(String placeName);

  List<PlaceModel> filterPlacesByRate();

  List<PlaceModel> filterPlacesByLocation(String cityName);

  Future<String> getUserAddress();
}
/// i should use filteredList in cubit instead of constant.allPlaces

class HomeRepositoryImp implements HomeRepository {
  @override
  Future<List<PlaceModel>> getAllPlaces() async {
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

  @override
  List<PlaceModel> filterPlacesByRate() {
    List<PlaceModel> results = [];

    results =
        Constants.allPlaces.where((place) => place.placeRate >= 8).toList();

    return results;
  }

  @override
  Future<String> getUserAddress() async {
    String address=await GeoLocatorService.getCurrentAddress();
    return address;
  }

  @override
  List<PlaceModel> filterPlacesByLocation(String cityName) {
    List<PlaceModel> results = [];
    print('salah $cityName');
    if (cityName.isEmpty) {
      return Constants.allPlaces;
    } else {

      results = Constants.allPlaces
          .where((place) =>
          place.cityOfPlace.toLowerCase().contains(cityName.toLowerCase().substring(0,3)))
          .toList();
    }
    return results;

  }
}
