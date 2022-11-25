import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

import '../Model/login.dart';

abstract class AuthRepository {
  Future<UserCredential> firebaseLogin(AuthModel authModel);
  Future<UserCredential> firebaseRegister(AuthModel authModel);
  Future<void> firebaseResetPassword(String email);
}

class AuthRepositoryImp implements AuthRepository {
  @override
  Future<UserCredential> firebaseLogin(AuthModel authModel) async {
    try {
      return await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: authModel.username,
        password: authModel.password,
      );
    } on FirebaseAuthException catch (e) {
      log(e.toString());
      if (e.code == 'user-not-found') {
        throw ('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        throw ('Wrong password provided for that user.');
      } else {
        throw e.code;
      }
    }
  }

  @override
  Future<UserCredential> firebaseRegister(AuthModel authModel) async {
    try {
      return await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: authModel.username,
        password: authModel.password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw ('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        throw ('The account already exists for that email.');
      }
      throw e.code;
    }
  }

  @override
  Future<void> firebaseResetPassword(String email) async {
    return await FirebaseAuth.instance
        .sendPasswordResetEmail(email: email)
        .catchError((e) {
      if (e.toString().contains("user-not-found")) {
        throw ('No user found for that email.');
      }
    });
  }
}
