import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../Features/Auth/Model/user.dart';
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
  getUserData() {
    return FirebaseAuth.instance.currentUser;
  }
}
