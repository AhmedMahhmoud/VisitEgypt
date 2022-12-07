import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../Enums/home_filters_enum.dart';
import '../../Logic/respository.dart';
import '../../Model/place_model.dart';
import '../../Model/place_review.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  int selectedIndex = 0;
  List<PlaceModel> allPlaces = [];
  List<PlaceModel> filteredPlaces = [];
  String userAddress = '';

  HomeCubit({required this.homeRepository}) : super(HomeInitial());

  final HomeRepository homeRepository;

  getAllPlaces() async {
    emit(ListLoading());
    allPlaces = await homeRepository.getAllPlaces();
    filteredPlaces = allPlaces;
    selectedIndex = HomeFilterType.allPlaces.value;
    emit(ListFinished(resultPlaces: filteredPlaces));
  }

  searchInPlaces(String placeName) {
    emit(ListLoading());
    filteredPlaces = homeRepository.searchInPlaces(placeName);
    emit(ListFinished(resultPlaces: filteredPlaces));
  }

  filterPlacesByLocation(String cityName) {
    emit(ListLoading());
    filteredPlaces = homeRepository.filterPlacesByLocation(cityName);
    selectedIndex = HomeFilterType.byLocation.value;
    emit(ListFinished(resultPlaces: filteredPlaces));
  }

  filterPlacesByRate() {
    emit(ListLoading());
    filteredPlaces = homeRepository.filterPlacesByRate();
    selectedIndex = HomeFilterType.bestRated.value;
    emit(ListFinished(resultPlaces: filteredPlaces));
  }

  getUserAddress() async {
    emit(UserAddressLoading());
    userAddress = await homeRepository.getUserAddress();
    emit(UserAddressLoaded(address: userAddress.toLowerCase()));
  }

  Future<List<PlaceReview>> getPlaceReviews(String placeName) async {
    return await homeRepository.getPlacesReviews(placeName);
  }

  addPlaceReview(
      String userID, String placeName, PlaceReview placeReview) async {
    await homeRepository.addPlaceReview(userID, placeName, placeReview);
  }
}
