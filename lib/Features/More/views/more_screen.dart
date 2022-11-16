import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../Auth/View/login_page.dart';

class MoreScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(onPressed: () {

          FirebaseAuth.instance.signOut();
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
          LoginPage(),
              ));
        }, child:Text('Logout') ,),
      ),
    );
  }
}
