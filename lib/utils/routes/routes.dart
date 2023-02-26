import 'package:flutter/material.dart';
import 'package:tech_media/utils/routes/route_name.dart';
import 'package:tech_media/view/dashboard.dart';
import 'package:tech_media/view/forgot_password.dart';
import 'package:tech_media/view/login_screen.dart';
import 'package:tech_media/view/sign_up_screen.dart';
import 'package:tech_media/view/splash_screen.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final arguments = settings.arguments;
    switch (settings.name) {
      case RouteName.splashScreen:
        return MaterialPageRoute(builder: (_) => const SplashScreen());

      case RouteName.loginScreen:
        return MaterialPageRoute(builder: (_) => const LoginScreen());

      case RouteName.registerScreen:
        return MaterialPageRoute(builder: (_) => const RegisterScreen());

      case RouteName.dashboardScreen:
        return MaterialPageRoute(builder: (_) => const DashboardScreen());

      case RouteName.forgotPasswordScreen:
        return MaterialPageRoute(builder: (_) => const ForgotPasswordScreen());

      default:
        return MaterialPageRoute(builder: (_) {
          return Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          );
        });
    }
  }
}
