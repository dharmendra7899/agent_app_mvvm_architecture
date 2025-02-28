import 'package:agent_app/injection_container.dart' as di;
import 'package:agent_app/modules/auth/view_model/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Providers extends StatelessWidget {
  final Widget widget;

  const Providers({super.key, required this.widget});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthProvider(
            authRepo: di.serviceLocator(),
            sessionManager: di.serviceLocator(),
          ),
        ),
      ],
      child: widget,
    );
  }
}
