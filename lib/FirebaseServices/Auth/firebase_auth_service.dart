import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../Features/Auth/Model/user.dart';
import '../../Features/Home/Model/tourguide_register_model.dart';
import '../Upload/firebase_upload_images.dart';
import '../firebase_services.dart';

class FirebaseAuthService extends FirebaseServices {
  @override
  addUserToFirestore(UserData user) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(user.userID)
        .set(user.toMap())
        .onError((error, stackTrace) => debugPrint(error.toString()));
    log("user added to firestore successfully");
  }

  @override
  updateUserData(String userID, TourguideRegisterModel registerModel) async {
    try {
      List<String> resultImageUrls = [];

      FirebaseUploadImagesService firebaseUploadImagesService =
          FirebaseUploadImagesService();

      resultImageUrls = await firebaseUploadImagesService
          .uploadImagesToFirestore(registerModel.images);
      log('resut images ${resultImageUrls.first}');

      await FirebaseFirestore.instance.collection("users").doc(userID).update({
        'phoneNumber': registerModel.phoneNumber,
        'userName': registerModel.userName,
        'images': resultImageUrls
      });
      print('updated trye');
      return true;
    } catch (e) {
      print('updated false');
      return false;
    }
  }

  @override
  Future<TourguideRegisterModel> getTourguideProfile() async {
    var userData = await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    print(userData);
    return TourguideRegisterModel.fromMap(userData.data()!);
  }

  @override
  getUserData() {
    return FirebaseAuth.instance.currentUser;
  }
}
