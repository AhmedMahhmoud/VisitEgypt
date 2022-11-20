import 'dart:convert';
import 'dart:io';

import 'package:equatable/equatable.dart';

class Posts extends Equatable {

  // in case posting
  final List<File> postImages;

  final String? postOwnerName;

  // in case retrieving
  final List<String>? retrievedPostImages;
  final String postContent;
  final String userID;
  final String locationName;
  const Posts({
     required this.postImages,
     this.retrievedPostImages,
     this.postOwnerName,
    required this.postContent,
    required this.locationName,
    required this.userID,
  });



  factory Posts.fromJson(json) {
    return Posts(
        postImages: json["images"],
        postContent: json["content"],
        userID: json["userID"],
        locationName: json["location"]);
  }
  @override
  List<Object?> get props =>
      [postContent, postContent, postImages, locationName];

  Map<String, dynamic> toMap() {
    return {
      'postImages': postImages,
      'postContent': postContent,
      'userID': userID,
      'location': locationName,
    };
  }

  String toJson() => json.encode(toMap());
}
