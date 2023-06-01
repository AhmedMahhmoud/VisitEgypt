import 'dart:convert';

class TripModel {
  final List<dynamic> locations;
  final String timeOfMeet;
  final double totalPrice;
  String? tripID;
  List<dynamic>? usersJoinedIDs;
  final String? description;
  final int numberOfJoiners;
  final String dayOfMeet;
  final String userID;
  final String tourGuideNumber;
  bool isStarted = false;
  bool hasEnded = false;
  final String tourGuideToken;
  TripModel({
    required this.locations,
    required this.timeOfMeet,
    required this.numberOfJoiners,
    required this.dayOfMeet,
    required this.userID,
    required this.tourGuideToken,
    required this.tourGuideNumber,
    this.tripID,
    required this.totalPrice,
    this.description,
    this.usersJoinedIDs,
    required this.hasEnded,
    required this.isStarted,
  });

  Map<String, dynamic> toMap() {
    return {
      'numberOfJoiners': numberOfJoiners,
      'locations': locations,
      'timeOfMeet': timeOfMeet,
      'tripID': tripID,
      'userID': userID,
      'dayOfMeet': dayOfMeet,
      'totalPrice': totalPrice,
      'hasEnded': hasEnded,
      'description': description,
      'isStarted': isStarted,
      'token': tourGuideToken,
      'tourGuideNumber': tourGuideNumber,
      'usersJoinedIds': usersJoinedIDs
    };
  }

  factory TripModel.fromMap(Map<String, dynamic> map) {
    return TripModel(
      tourGuideNumber: map['tourGuideNumber'],
      hasEnded: map['hasEnded'],
      userID: map['userID'] ?? '',
      dayOfMeet: map['dayOfMeet'],
      tourGuideToken: map['token'] ?? '',
      numberOfJoiners: map['numberOfJoiners'],
      tripID: map['tripID'] ?? '',
      locations: map['locations'],
      usersJoinedIDs: map['usersJoinedIds'] ?? [],
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
