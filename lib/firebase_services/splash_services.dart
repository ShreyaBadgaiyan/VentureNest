// import 'dart:async';

// import 'package:core/auth/login_screen.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// class SplashServices {
//   void isLogin(BuildContext context) {
//     final auth = FirebaseAuth.instance;

//     final user = auth.currentUser;

//     if (user != null) {
//       Timer(const Duration(seconds: 3), () {
//         Navigator.push(context,
//             MaterialPageRoute(builder: (context) => const UploadImageScreen()));
//       });
//     } else {
//       Timer(const Duration(seconds: 3), () {
//         Navigator.push(context,
//             MaterialPageRoute(builder: (context) => const LoginScreen()));
//       });
//     }
//   }
// }

import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ui/auth/login_screen.dart';
import 'package:ui/auth/post_screen.dart';
import 'package:ui/auth/post_screen_2.dart';
import 'package:ui/entrepreneur_screens/bottomnavbar.dart';
import 'package:ui/entrepreneur_screens/home.dart';
import 'package:ui/investor_screens/ibottomnavigationbar.dart';
import 'package:ui/investor_screens/ihome.dart';

class SplashServices {
  void isLogin(BuildContext context) async {
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? role = prefs.getString('role');

    Timer(const Duration(seconds: 3), () {
      if (user != null) {
        if (role == 'entrepreneur') {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => NavigationMenu(
                      uid: user.uid,
                    )),
          );
        } else if (role == 'investor') {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => INavigationMenu(
                      uid: user.uid,
                    )),
          );
        } else {
          // fallback if role is not set
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const LoginScreen()),
          );
        }
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      }
    });
  }
}
