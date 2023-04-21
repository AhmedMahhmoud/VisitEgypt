import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';

class PredictedPlace extends Equatable {
  const PredictedPlace(
      { required this.placeName,required this.placeDescription,required this.placeLat,required this.placeLng, });

  final String placeName;
  final String placeDescription;
  final double placeLat;
  final double placeLng;

  @override
  List<Object?> get props => [placeName,placeDescription,placeLat,placeLng];


}
