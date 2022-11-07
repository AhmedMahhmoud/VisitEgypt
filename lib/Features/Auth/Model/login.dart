import 'package:equatable/equatable.dart';

class AuthModel extends Equatable {
  final String username;
  final String password;
  const AuthModel({required this.username, required this.password});

  @override
  List<Object?> get props => [username, password];
}
