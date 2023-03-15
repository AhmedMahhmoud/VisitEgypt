part of 'trips_cubit.dart';

abstract class TripsState extends Equatable {
  const TripsState();

  @override
  List<Object> get props => [];
}

class TripsInitial extends TripsState {}

class TripsLoadingState extends TripsState {}

class TripsLoadedState extends TripsState {}

class TripsErrorState extends TripsState {
  final String errorMessage;
  const TripsErrorState(this.errorMessage);
}
