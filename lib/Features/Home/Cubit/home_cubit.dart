import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';


import '../Logic/respository.dart';
import '../Model/place_model.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  int selectedIndex = 0;
  List<PlaceModel> allPlaces=[];
  List<PlaceModel> filteredPlaces=[];


  HomeCubit({required this.homeRepository}) : super(HomeInitial());

  final HomeRepository homeRepository;

  getAllPlaces(){
    emit(SearchLoading());
    allPlaces=homeRepository.getAllPlaces();
    filteredPlaces=allPlaces;
    emit(SearchFinished(resultPlaces: filteredPlaces));


  }

  searchInPlaces(String placeName){
    emit(SearchLoading());
    filteredPlaces=homeRepository.searchInPlaces(placeName);
    emit(SearchFinished(resultPlaces: filteredPlaces));

  }



}
