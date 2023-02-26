import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:tech_media/utils/routes/route_name.dart';
import 'package:tech_media/utils/utils.dart';
import 'package:tech_media/view_model/services/session_controller.dart';

class LoginProvider with ChangeNotifier {
  final auth = FirebaseAuth.instance;
  DatabaseReference ref = FirebaseDatabase.instance.ref().child('users');

  bool _loading = false;
  bool get loading => _loading;

  void setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  void logIn(BuildContext context, String email, String password) async {
    setLoading(true);

    try {
      auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
        // Store the userId first:
        SessionController().userId = value.user!.uid;

        setLoading(false);

        Utils.toastMessage('Welcome back $email');

        Navigator.pushNamed(context, RouteName.dashboardScreen);
      }).onError((error, stackTrace) {
        setLoading(false);

        Utils.toastMessage(error.toString());
      });
    } catch (e) {
      setLoading(false);

      Utils.toastMessage(e.toString());
    }
  }

  // logOut:
  void logOut(BuildContext context) async {
    try {
      auth.signOut().then((value) {
        // Remove the Session value (userId):
        SessionController().userId = '';

        Utils.toastMessage('Successflly Logged Out');

        Navigator.pushReplacementNamed(context, RouteName.loginScreen);
      }).onError((error, stackTrace) {
        Utils.toastMessage(error.toString());
      });
    } catch (e) {
      Utils.toastMessage(e.toString());
    }
  }
}
