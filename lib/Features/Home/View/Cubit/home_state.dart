part of 'home_cubit.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class SearchLoading extends HomeState {}

class SearchFinished extends HomeState {
  final List<PlaceModel> resultPlaces;
  const SearchFinished({required this.resultPlaces});
  @override
  List<Object> get props => [resultPlaces];
}


