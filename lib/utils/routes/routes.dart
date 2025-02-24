import 'package:agent_app/utils/routes/routes_names.dart' show RouteNames;
import 'package:agent_app/view/auth_screen/forgot_password.dart';
import 'package:agent_app/view/auth_screen/login_screen.dart' show LoginScreen;
import 'package:agent_app/view/auth_screen/signup_screen.dart' show SignUpScreen;
import 'package:agent_app/view/splash_screen/splash_screen.dart' show SplashScreen;
import 'package:flutter/material.dart';


class Routes {
  static Route<dynamic> generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case (RouteNames.splashScreen):
        return MaterialPageRoute(
            builder: (BuildContext context) => const SplashScreen());
      case (RouteNames.login):
        return MaterialPageRoute(
            builder: (BuildContext context) => const LoginScreen());
      case (RouteNames.signupScreen):
        return MaterialPageRoute(
            builder: (BuildContext context) => const SignUpScreen());
      case (RouteNames.forgetPasswordScreen):
        return MaterialPageRoute(
            builder: (BuildContext context) =>  ForgotPassword());
      
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
              child: Text("No route is configured"),
            ),
          ),
        );
    }
  }
}
