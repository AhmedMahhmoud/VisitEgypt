part of 'login_cubit.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoadingLoginState extends LoginState {}

class LoadedLoginState extends LoginState {
  final UserCredential userCredential;
  const LoadedLoginState({required this.userCredential});
  @override
  List<Object> get props => [userCredential];
}

class ErrorLoginState extends LoginState {
  final String errorMsg;
  const ErrorLoginState({required this.errorMsg});
  @override
  List<Object> get props => [errorMsg];
}
