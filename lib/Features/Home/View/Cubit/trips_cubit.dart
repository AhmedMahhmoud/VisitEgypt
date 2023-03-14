import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visit_egypt/Features/Home/Logic/trip_trepository.dart';

import '../../Model/tourguide_trip.dart';
part 'trips_state.dart';

class TripsCubit extends Cubit<TripsState> {
  final TripRepo tripRepo;
  TripsCubit({required this.tripRepo}) : super(TripsInitial());
  List<TripModel> tripsList = [];
  Future addNewTrip(TripModel tripModel) async {
    emit(TripsLoadingState());
    await tripRepo.createNewTrip(tripModel);
    emit(TripsLoadedState());
  }

  resetState() {
    emit(TripsInitial());
  }

  Future getCreatedTrips() async {
    emit(TripsLoadingState());
    tripsList = await tripRepo.getAllCreatedTripsByUserId();
    emit(TripsLoadedState());
  }
}
