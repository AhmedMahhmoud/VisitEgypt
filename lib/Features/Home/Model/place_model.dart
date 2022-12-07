import 'package:equatable/equatable.dart';

class PlaceModel extends Equatable {

  final int placeId;
  final String placeName;
  final String cityOfPlace;
  final String placeDescription;
  final String placeImage;
  final double placeRate;
final List<String>?placeImagesList;
  const PlaceModel( {required this.placeId,required this.cityOfPlace,required this.placeName, required this.placeDescription,
    required this.placeImage, required this.placeRate,this.placeImagesList,});

  @override
  List<Object?> get props => [placeId,placeName, cityOfPlace,placeDescription,placeImage,placeRate,placeImagesList];
}
