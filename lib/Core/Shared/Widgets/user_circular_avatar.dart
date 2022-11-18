import 'package:flutter/material.dart';
import 'package:task/FirebaseServices/Auth/firebase_auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserCircularAvatar extends StatelessWidget {
  const UserCircularAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    final FirebaseAuthService authService = FirebaseAuthService();
    final User user = authService.getUserData();
    return CircleAvatar(
      radius: 25,
      child: Center(
        child: Text(
          user.email!.substring(0, 1).toUpperCase(),
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
        ),
      ),
    );
  }
}
