import 'dart:async';

import 'package:agent_app/res/widgets/context_extension.dart';
import 'package:agent_app/utils/routes/routes_names.dart';
import 'package:agent_app/viewModel/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late Timer timer;

  @override
  void initState() {
    super.initState();
    checkAuthentication(context);
  }

  void checkAuthentication(BuildContext context) async {
    timer = Timer(const Duration(seconds: 4), () async {
      var user = AuthViewModel(await SharedPreferences.getInstance());
      if (user.token.toString() == "null" || user.token.toString() == "") {
        await Future.delayed(const Duration(seconds: 4));
        if (context.mounted) {
          Navigator.pushNamed(context, RouteNames.login);
        }
      } else {
        await Future.delayed(const Duration(seconds: 3));
        if (context.mounted) {
          Navigator.pushNamed(context, RouteNames.login);
          // Navigator.pushNamed(context, RouteNames.home);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Text(
                "Splash Screen",
                style: context.textTheme.headlineLarge,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
