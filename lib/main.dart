import 'package:agent_app/app.dart' show App;
import 'package:agent_app/providers.dart' show Providers;
import 'package:flutter/material.dart';

void main() {
  runApp(
    const Providers(
      widget: App(),
    ),
  );
}