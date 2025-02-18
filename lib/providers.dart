import 'package:agent_app/viewModel/auth_provider.dart' show AuthViewModel;
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
          create: (context) => AuthViewModel(),
        ),
      ],
      child: widget,
    );
  }
}
