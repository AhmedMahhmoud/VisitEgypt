import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';

class UserData extends Equatable {
  const UserData({
    required this.email,
    required this.userID,
    required this.username,
    required this.userLocation,
  });

  final String email;
  final String userID;
  final Position userLocation;
  final String username;

  @override
  List<Object?> get props => [email, username, userLocation];

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      // 'username': username,
      'userLocation': {
        "lat": userLocation.latitude,
        "lng": userLocation.longitude
      },
    };
  }

  static parseUserCridentalToUserData(
      UserCredential userCredential, Position userCurrentLocation) {
    return UserData(
        email: userCredential.user!.email ?? "",
        userID: userCredential.user!.uid,
        username: userCredential.user!.email ?? "",
        userLocation: userCurrentLocation);
  }

  String toJson() => json.encode(toMap());
}
