import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';

class UserData extends Equatable {
  const UserData(
      {required this.email,
      required this.userID,
      required this.username,
      this.isTourGuideActivated,
      required this.userLocation,
      this.fcmToken,
      required this.userType});
  final String? fcmToken;
  final String email;
  final String userID;
  final Position userLocation;
  final String username;
  final String userType;
  final String? isTourGuideActivated;
  @override
  List<Object?> get props => [email, username, userLocation, fcmToken];

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'fcmToken': fcmToken,
      'userType': userType,
      'isTourguideActivated': isTourGuideActivated ?? false,
      // 'username': username,
      'userLocation': {
        "lat": userLocation.latitude,
        "lng": userLocation.longitude
      },
    };
  }

  static parseUserCridentalToUserData(UserCredential userCredential,
      Position userCurrentLocation, String userType, token) {
    return UserData(
        userType: userType,
        email: userCredential.user!.email ?? "",
        userID: userCredential.user!.uid,
        username: userCredential.user!.email ?? "",
        userLocation: userCurrentLocation,
        fcmToken: token);
  }

  String toJson() => json.encode(toMap());
}
