import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:geolocator/geolocator.dart';

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

  Future<void> firebaseSignUp(AuthModel authModel) async {
    makeFirebaseRequest(FirebaseRequestType.register, authModel);
  }

  Future<void> firebaseResetPassword(AuthModel auth) async {
    makeFirebaseRequest(FirebaseRequestType.forget, auth);
  }

  Future<void> firebaseSignIn(AuthModel loginModel) async {
    makeFirebaseRequest(FirebaseRequestType.login, loginModel);
  }

  Future<void> makeFirebaseRequest(
      FirebaseRequestType requestType, AuthModel authModel) async {
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
        } else if (requestType == FirebaseRequestType.register) {
          userCridentials = await signUpUser(authModel);
        }
        emit(LoadedAuthState(userCredential: userCridentials!));
      }
    } catch (e) {
      emit(ErrorAuthState(errorMsg: e.toString()));
    }
  }

  signUpUser(AuthModel authModel) async {
    try {
      late UserCredential userCridentials;
      final FirebaseAuthService firebaseAuthService = FirebaseAuthService();

      Position userLocation = await GeoLocatorService.getCurrentUserLocation();

      try {
        userCridentials = await authRepository.firebaseRegister(authModel);
      } catch (e) {
        rethrow;
      }
      final UserData user =
          UserData.parseUserCridentalToUserData(userCridentials, userLocation);
      await firebaseAuthService.addUserToFirestore(user);
      return userCridentials;
    } catch (e) {
      rethrow;
    }
  }
}
