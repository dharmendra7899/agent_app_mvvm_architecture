import 'dart:async';

import 'package:agent_app/modules/auth/view_model/auth_provider.dart';
import 'package:agent_app/res/widgets/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    _navigation();
    super.initState();
  }

  _navigation() async {
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Provider.of<AuthProvider>(
          context,
          listen: false,
        ).validateNavigation(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
    );
  }
}
