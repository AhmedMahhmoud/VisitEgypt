import 'dart:convert';

class TripModel {
  final List<dynamic> locations;
  final String timeOfMeet;
  final double totalPrice;
  String? tripID;
  final String? description;
  final int numberOfJoiners;
  final String dayOfMeet;
  bool isStarted = false;
  TripModel({
    required this.locations,
    required this.timeOfMeet,
    required this.numberOfJoiners,
    required this.dayOfMeet,
    this.tripID,
    required this.totalPrice,
    this.description,
    required this.isStarted,
  });

  Map<String, dynamic> toMap() {
    return {
      'numberOfJoiners': numberOfJoiners,
      'locations': locations,
      'timeOfMeet': timeOfMeet,
      'dayOfMeet': dayOfMeet,
      'totalPrice': totalPrice,
      'description': description,
      'isStarted': isStarted,
    };
  }

  factory TripModel.fromMap(Map<String, dynamic> map) {
    return TripModel(
      dayOfMeet: map['dayOfMeet'],
      numberOfJoiners: map['numberOfJoiners'],
      locations: map['locations'],
      timeOfMeet: map['timeOfMeet'] ?? '',
      totalPrice: map['totalPrice']?.toDouble() ?? 0.0,
      description: map['description'],
      isStarted: map['isStarted'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory TripModel.fromJson(String source) =>
      TripModel.fromMap(json.decode(source));
}
