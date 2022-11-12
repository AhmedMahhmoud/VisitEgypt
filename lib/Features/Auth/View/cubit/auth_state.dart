part of 'auth_cubit.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class LoadingAuthState extends AuthState {}

class LoadedAuthState extends AuthState {
  final UserCredential userCredential;
  const LoadedAuthState({required this.userCredential});
  @override
  List<Object> get props => [userCredential];
}

class LoadedForgetPasswordState extends AuthState {}

class LoadingForgetPasswordState extends AuthState {}

class ErrorAuthState extends AuthState {
  final String errorMsg;
  const ErrorAuthState({required this.errorMsg});
  @override
  List<Object> get props => [errorMsg];
}
