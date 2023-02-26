import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tech_media/utils/routes/route_name.dart';
import 'package:tech_media/utils/utils.dart';

class ForgotProvider with ChangeNotifier {
  final auth = FirebaseAuth.instance;

  bool _loading = false;
  bool get loading => _loading;

  void setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  void forgotPassword(BuildContext context, String email) async {
    setLoading(true);

    try {
      auth.sendPasswordResetEmail(email: email).then((value) {
        setLoading(false);

        Navigator.pushNamed(context, RouteName.loginScreen);

        Utils.toastMessage(
            'A link has been send to your email, Confirm it to reset password.');
      }).onError((error, stackTrace) {
        setLoading(false);

        Utils.toastMessage(error.toString());
      });
    } catch (e) {
      setLoading(false);
      Utils.toastMessage(e.toString());
    }
  }
}
