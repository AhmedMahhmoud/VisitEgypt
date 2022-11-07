import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:task/Features/Login/Model/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  Future<void> firebaseSignUp(LoginModel loginModel) async {
    try {
      emit(LoadingLoginState());
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: loginModel.username,
        password: loginModel.password,
      );
      log(credential.toString());
      emit(LoadedLoginState(userCredential: credential));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        debugPrint('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        debugPrint('The account already exists for that email.');
      }
      emit(ErrorLoginState(errorMsg: e.code));
    }
  }

  Future<void> firebaseSignIn(LoginModel loginModel) async {
    try {
      emit(LoadingLoginState());
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: loginModel.username,
        password: loginModel.password,
      );
      log(credential.toString());
      emit(LoadedLoginState(userCredential: credential));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        debugPrint('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        debugPrint('Wrong password provided for that user.');
      }
      emit(ErrorLoginState(errorMsg: e.code));
    }
  }
}
