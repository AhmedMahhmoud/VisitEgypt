import 'package:equatable/equatable.dart';

import 'place_model.dart';

class CityModel extends Equatable {
  final String name;
  final List<PlaceModel> famousPlaces;

  const CityModel({required this.name, required this.famousPlaces});

  @override
  List<Object?> get props => [name,famousPlaces];

}