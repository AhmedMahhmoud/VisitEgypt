import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:geolocator/geolocator.dart';
import 'package:visit_egypt/Enums/user_type.dart';

import '../../../../Core/Shared/SharedPreferences (Singelton)/shared_pref.dart';
import '../../../../Enums/firebase_request_enum.dart';
import '../../../../FirebaseServices/Auth/firebase_auth_service.dart';
import '../../../../Services/Geolocator/geolocator.dart';
import '../../Logic/respository.dart';
import '../../Model/login.dart';
import '../../Model/user.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({required this.authRepository}) : super(AuthInitial());

  final AuthRepository authRepository;
  UserTypeEnum userTypeEnum = UserTypeEnum.tourist;
  Future<void> firebaseSignUp(AuthModel authModel, String userType) async {
    makeFirebaseRequest(FirebaseRequestType.register, authModel,
        userType: userType);
  }

  Future<void> firebaseResetPassword(AuthModel auth) async {
    makeFirebaseRequest(FirebaseRequestType.forget, auth);
  }

  Future<void> firebaseSignIn(AuthModel loginModel) async {
    makeFirebaseRequest(FirebaseRequestType.login, loginModel);
  }

  Future<void> makeFirebaseRequest(
      FirebaseRequestType requestType, AuthModel authModel,
      {String? userType}) async {
    UserCredential? userCridentials;
    try {
      if (requestType == FirebaseRequestType.forget) {
        emit(LoadingForgetPasswordState());
        await authRepository.firebaseResetPassword(authModel.username);
        emit(LoadedForgetPasswordState());
      } else {
        emit(LoadingAuthState());
        if (requestType == FirebaseRequestType.login) {
          log(authModel.toString());
          userCridentials = await authRepository.firebaseLogin(authModel);
          Prefs.setStringList(
                  "userData", [authModel.username, authModel.password])
              .whenComplete(() => log("user cached"));
          var loginData = await FirebaseFirestore.instance
              .collection('users')
              .doc(userCridentials.user!.uid)
              .get();
          if (loginData.data()!['userType'] == 'tourist') {
            userTypeEnum = UserTypeEnum.tourist;
          } else {
            userTypeEnum = UserTypeEnum.tourguide;
          }
        } else if (requestType == FirebaseRequestType.register) {
          userCridentials = await signUpUser(authModel, userType!);
        }
        emit(LoadedAuthState(userCredential: userCridentials!));
      }
    } catch (e) {
      emit(ErrorAuthState(errorMsg: e.toString()));
    }
  }

  signUpUser(AuthModel authModel, String userType) async {
    try {
      late UserCredential userCridentials;
      final FirebaseAuthService firebaseAuthService = FirebaseAuthService();

      Position userLocation = await GeoLocatorService.getCurrentUserLocation();

      try {
        userCridentials = await authRepository.firebaseRegister(authModel);
      } catch (e) {
        rethrow;
      }
      final UserData user = UserData.parseUserCridentalToUserData(
          userCridentials, userLocation, userType);
      await firebaseAuthService.addUserToFirestore(user);
      return userCridentials;
    } catch (e) {
      rethrow;
    }
  }
}
