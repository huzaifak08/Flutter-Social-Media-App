import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:tech_media/utils/routes/route_name.dart';
import 'package:tech_media/utils/utils.dart';
import 'package:tech_media/view/dashboard.dart';

class SignUpProvider with ChangeNotifier {
  final auth = FirebaseAuth.instance;
  DatabaseReference ref = FirebaseDatabase.instance.ref().child('users');

  bool _loading = false;
  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  void signUp(BuildContext context, String userName, String email,
      String password) async {
    setLoading(true);
    try {
      auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
        // Storing Users in Realtime Database:
        ref.child(value.user!.uid).set({
          'uid': value.user!.uid.toString(),
          'email': email,
          'userName': userName,
          'password': password,
          'online_status': 'none',
          'profile': '',
          'phone': '',
        }).then((value) {
          setLoading(false);

          Navigator.pushNamed(context, RouteName.dashboardScreen);
        }).onError((error, stackTrace) {
          setLoading(false);

          Utils.toastMessage(error.toString());
        });

        setLoading(false);

        Utils.toastMessage('Account Created Successfully $userName');
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
