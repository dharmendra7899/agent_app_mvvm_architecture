import 'package:agent_app/viewModel/auth_provider.dart' show AuthViewModel;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Providers extends StatelessWidget {
  final Widget widget;
  final AuthViewModel state;

  const Providers({super.key, required this.widget, required this.state});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => state,
        ),
      ],
      child: widget,
    );
  }
}
