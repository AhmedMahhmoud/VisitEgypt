import 'package:flutter/cupertino.dart';
import 'package:task/Features/Auth/Model/login.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepository {
  Future<UserCredential> firebaseLogin(AuthModel authModel);
  Future<UserCredential> firebaseRegister(AuthModel authModel);
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
      if (e.code == 'user-not-found') {
        debugPrint('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        debugPrint('Wrong password provided for that user.');
      }
      throw e.code;
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
        debugPrint('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        debugPrint('The account already exists for that email.');
      }
      throw e.code;
    }
  }
}
