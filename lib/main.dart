import 'package:agent_app/app.dart' show App;
import 'package:agent_app/injection_container.dart' as di;
import 'package:agent_app/providers.dart' show Providers;
import 'package:flutter/material.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  di.init();
  runApp(
    const Providers(
      widget: App(),
    ),
  );
}