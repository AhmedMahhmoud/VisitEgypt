import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:task/Features/Auth/View/login_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Hello There"),
            ElevatedButton(
                onPressed: () {
                  FirebaseAuth.instance
                      .signOut()
                      .then((value) => Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginPage(),
                          )));
                },
                child: const Text("Sign out"))
          ],
        ),
      ),
    );
  }
}
