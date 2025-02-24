import 'package:agent_app/app.dart' show App;
import 'package:agent_app/providers.dart' show Providers;
import 'package:agent_app/viewModel/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  var state = AuthViewModel(await SharedPreferences.getInstance());
  runApp(Providers(widget: App(), state: state));
}
