import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visit_egypt/Features/Home/Logic/trip_trepository.dart';

import '../../Model/tourguide_trip.dart';
part 'trips_state.dart';

class TripsCubit extends Cubit<TripsState> {
  final TripRepo tripRepo;
  TripsCubit({required this.tripRepo}) : super(TripsInitial());
  List<TripModel> tripsListByID = [];
  List<TripModel> allTrips = [];

  Future addNewTrip(TripModel tripModel) async {
    emit(TripsLoadingState());
    await tripRepo.createNewTrip(tripModel);
    emit(TripsLoadedState());
  }

  resetState() {
    emit(TripsInitial());
  }

  // getTripsByLocation(String location) async {
  //   singleFilteredList = allTrips
  //       .where((element) => element.locations.contains(location))
  //       .where((element) => element.locations.length == 1)
  //       .toList();
  //   multipleFitleredList = allTrips
  //       .where((element) =>
  //           element.locations.length > 1 &&
  //           element.locations.contains(location))
  //       .toList();
  // }
  joinTrip(tripID, tourGuideID, trip) async {
    emit(JoinTripLoadingState());
    await tripRepo.handleJoinAndCancelTrip(tripID, tourGuideID, trip);
    emit(JoinTripLoadedState());
  }

  endTrip(TripModel trip) async {
    emit(TripsLoadingState());
    await tripRepo.endTrip(trip);
    emit(TripsLoadedState());
  }

  startTrip(TripModel trip) async {
    emit(TripsLoadingState());
    await tripRepo.startTrip(trip);
    tripsListByID = await tripRepo.getAllCreatedTripsByUserId();
    emit(TripsLoadedState());
  }

  getAllcreatedTrips() async {
    emit(TripsLoadingState());
    allTrips = await tripRepo.getAllcreatedTrips();
    allTrips = allTrips.where((element) => element.isStarted == false).toList();
    emit(TripsLoadedState());
  }

  Future getCreatedTrips() async {
    emit(TripsLoadingState());
    tripsListByID = await tripRepo.getAllCreatedTripsByUserId();
    emit(TripsLoadedState());
  }
}
