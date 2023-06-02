part of 'home_cubit.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class ListLoading extends HomeState {}

class UserAddressLoading extends HomeState {}

class UserAddressLoaded extends HomeState {
  final String address;
  const UserAddressLoaded({required this.address});
  @override
  List<Object> get props => [address];
}

class ListFinished extends HomeState {
  final List<PlaceModel> resultPlaces;
  const ListFinished({required this.resultPlaces});
  @override
  List<Object> get props => [resultPlaces];
}
