import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tech_media/utils/routes/route_name.dart';
import 'package:tech_media/view_model/services/session_controller.dart';

class SplashServices {
  void isLogin(BuildContext context) {
    final auth = FirebaseAuth.instance;

    final user = auth.currentUser;

    if (user != null) {
      // If user is already login:

      // Store the userId first:
      SessionController().userId = user.uid.toString();

      Timer(const Duration(seconds: 3),
          () => Navigator.pushNamed(context, RouteName.dashboardScreen));
    } else {
      // if user is not login:

      Timer(const Duration(seconds: 3),
          () => Navigator.pushNamed(context, RouteName.loginScreen));
    }
  }
}
