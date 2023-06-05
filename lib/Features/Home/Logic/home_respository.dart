import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visit_egypt/Features/Home/Model/place_review.dart';

import '../../../Core/Constants/constants.dart';
import '../../../Services/Geolocator/geolocator.dart';
import '../../../main.dart';
import '../Model/place_model.dart';
import '../View/Cubit/home_cubit.dart';

abstract class HomeRepository {
  Future<List<PlaceModel>> getAllPlaces();
  List<PlaceModel> searchInPlaces(String placeName);
  Future<List<PlaceReview>> getPlacesReviews(String placeName);
  List<PlaceModel> filterPlacesByRate();
  addPlaceReview(String userID, String placeName, PlaceReview placeReview);
  List<PlaceModel> filterPlacesByLocation(String cityName);

  Future<String> getUserAddress();

  String mapCityName(String cityName);
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
      if (BlocProvider.of<HomeCubit>(navigatorKey.currentState!.context)
              .selectedIndex ==
          2) {
        return filterPlacesByLocation(
            BlocProvider.of<HomeCubit>(navigatorKey.currentState!.context)
                .userAddress);
      } else if (BlocProvider.of<HomeCubit>(navigatorKey.currentState!.context)
              .selectedIndex ==
          1) {
        return filterPlacesByRate();
      } else {
        return Constants.allPlaces;
      }
    } else {
      results = BlocProvider.of<HomeCubit>(navigatorKey.currentState!.context)
          .filteredPlaces
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
    String address = await GeoLocatorService.getCurrentAddress();
    return address;
  }

  @override
  List<PlaceModel> filterPlacesByLocation(String cityName) {
    print(cityName);
    List<PlaceModel> results = [];
    if (cityName.isEmpty) {
      return Constants.allPlaces;
    } else {
      results = Constants.allPlaces
          .where((place) => place.cityOfPlace
              .toLowerCase()
              .contains(mapCityName(cityName).toLowerCase().substring(0, 3)))
          .toList();
    }
    return results;
  }

  @override
  String mapCityName(String cityName) {
    String finalCityName = '';
    if (cityName.toLowerCase().contains('cai') || cityName.contains('قاهر')) {
      finalCityName = 'cairo';
    } else if (cityName.toLowerCase().contains('giz') ||
        cityName.contains('جيز')) {
      finalCityName = 'giza';
    } else if (cityName.toLowerCase().contains('aswa') ||
        cityName.contains('سوا')) {
      finalCityName = 'aswan';
    } else if (cityName.toLowerCase().contains('el qa') ||
        cityName.contains('قلي')) {
      finalCityName = 'qualiobya';
    }
    return finalCityName;
  }

  @override
  addPlaceReview(
      String userID, String placeName, PlaceReview placeReview) async {
    await FirebaseFirestore.instance
        .collection(Constants.placesCollection)
        .doc(placeName)
        .collection('reviews')
        .doc(userID)
        .set({'userReview': placeReview.toMap()});
  }

  @override
  Future<List<PlaceReview>> getPlacesReviews(String placeName) async {
    List<PlaceReview> reviewsList = [];
    var x = await FirebaseFirestore.instance
        .collection(Constants.placesCollection)
        .doc(placeName)
        .collection('reviews')
        .get();
    for (int i = 0; i < x.docs.length; i++) {
      reviewsList.add(PlaceReview.fromMap(x.docs[i].data()['userReview']));
    }

    return reviewsList;
  }
}
