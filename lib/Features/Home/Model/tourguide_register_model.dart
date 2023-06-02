import 'dart:convert';
import 'dart:io';

class TourguideRegisterModel {
  final String userName, phoneNumber;
  final List<File> images;
  final String? userImage;
  String? id;
  final String? userDegreeImage;
  final bool? isAccountActivated;
  final String? token;
  TourguideRegisterModel(
      {required this.phoneNumber,
      required this.images,
      this.id,
      required this.isAccountActivated,
      this.userImage,
      this.userDegreeImage,
      required this.token,
      required this.userName});

  Map<String, dynamic> toMap() {
    return {'phoneNumber': phoneNumber, 'userName': userName, 'images': images};
  }

  factory TourguideRegisterModel.fromMap(Map<String, dynamic> map) {
    return TourguideRegisterModel(
      images: [],
      phoneNumber: map['phoneNumber'],
      userDegreeImage: map['images'][1],
      isAccountActivated: map['isTourguideActivated'],
      userImage: map['images'][0],
      token: map['fcmToken'] ?? '',
      userName: map['userName'],
    );
  }

  String toJson() => json.encode(toMap());

  factory TourguideRegisterModel.fromJson(String source) =>
      TourguideRegisterModel.fromMap(json.decode(source));
}
