import 'package:flutter/material.dart';
import 'package:tech_media/res/color.dart';
import 'package:tech_media/res/fonts.dart';
import 'package:tech_media/utils/routes/route_name.dart';
import 'package:tech_media/utils/routes/routes.dart';
import 'package:tech_media/view/login/login_screen.dart';
import 'package:tech_media/view/splash/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: AppColors.primaryMaterialColor,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          color: AppColors.whiteColor,
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontSize: 22,
            fontFamily: AppFonts.sfProDisplayMedium,
            color: AppColors.primaryTextTextColor,
          ),
        ),
        textTheme: const TextTheme(
          // heading 1:
          displayLarge: TextStyle(
            fontSize: 40,
            fontFamily: AppFonts.sfProDisplayMedium,
            color: AppColors.primaryTextTextColor,
            fontWeight: FontWeight.w500,
            height: 1.6,
          ),

          // heading 2:
          displayMedium: TextStyle(
            fontSize: 32,
            fontFamily: AppFonts.sfProDisplayMedium,
            color: AppColors.primaryTextTextColor,
            fontWeight: FontWeight.w500,
            height: 1.6,
          ),

          // heading 3:
          displaySmall: TextStyle(
            fontSize: 28,
            fontFamily: AppFonts.sfProDisplayMedium,
            color: AppColors.primaryTextTextColor,
            fontWeight: FontWeight.w500,
            height: 1.9,
          ),

          // heading 4:
          headlineMedium: TextStyle(
            fontSize: 24,
            fontFamily: AppFonts.sfProDisplayMedium,
            color: AppColors.primaryTextTextColor,
            fontWeight: FontWeight.w500,
            height: 1.6,
          ),

          // heading 5:
          headlineSmall: TextStyle(
            fontSize: 20,
            fontFamily: AppFonts.sfProDisplayMedium,
            color: AppColors.primaryTextTextColor,
            fontWeight: FontWeight.w500,
            height: 1.6,
          ),

          // heading 6:
          titleLarge: TextStyle(
            fontSize: 17,
            fontFamily: AppFonts.sfProDisplayBold,
            color: AppColors.primaryTextTextColor,
            fontWeight: FontWeight.w700,
            height: 1.6,
          ),

          // bodyText 1:
          bodyLarge: TextStyle(
            fontSize: 17,
            fontFamily: AppFonts.sfProDisplayBold,
            color: AppColors.primaryTextTextColor,
            fontWeight: FontWeight.w700,
            height: 1.6,
          ),

          // bodyText 2:
          bodyMedium: TextStyle(
            fontSize: 14,
            fontFamily: AppFonts.sfProDisplayRegular,
            color: AppColors.primaryTextTextColor,
            height: 1.6,
          ),

          // Caption:
          bodySmall: TextStyle(
            fontSize: 12,
            fontFamily: AppFonts.sfProDisplayRegular,
            color: AppColors.primaryTextTextColor,
            height: 2.26,
          ),
        ),
      ),

      // You can't use home: property if you are using routing:
      initialRoute: RouteName.splashScreen,
      onGenerateRoute: Routes.generateRoute,
    );
  }
}
