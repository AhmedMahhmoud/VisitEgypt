import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:task/Features/Auth/Model/user.dart';
import 'package:task/FirebaseServices/firebase_services.dart';

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
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
