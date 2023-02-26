import 'package:flutter/material.dart';
import 'package:tech_media/res/fonts.dart';
import 'package:tech_media/view_model/services/splash_services.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashServices splashServices = SplashServices();

  @override
  void initState() {
    splashServices.isLogin(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          const Image(image: AssetImage('assets/images/logo.jpg')),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Center(
                child: Text(
              'Tech Brothers Media',
              style: TextStyle(
                  fontFamily: AppFonts.sfProDisplayBold,
                  fontSize: 40,
                  fontWeight: FontWeight.w700),
            )),
          )
        ],
      )),
    );
  }
}
