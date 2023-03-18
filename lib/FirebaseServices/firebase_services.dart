import 'dart:io';

import '../Features/Auth/Model/user.dart';
import '../Features/Home/Model/tourguide_register_model.dart';

abstract class FirebaseServices {
  addUserToFirestore(UserData user) {}
  getUserData() {}
  Future<bool> updateUserData(
      String userID, TourguideRegisterModel registerModel);
  uploadImagesToFirestore(List<File> images) {}
  Future<TourguideRegisterModel> getTourguideProfile();
}
