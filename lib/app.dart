import 'package:agent_app/theme/theme.dart' show AppTheme;
import 'package:agent_app/utils/routes/routes.dart' show Routes;
import 'package:agent_app/utils/routes/routes_names.dart' show RouteNames;
import 'package:flutter/material.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.light,
      theme: AppTheme.lightThemeMode,
      darkTheme: AppTheme.darkThemeMode,
      locale: Locale('en'),
      debugShowCheckedModeBanner: false,
      initialRoute: RouteNames.splashScreen,
      onGenerateRoute: Routes.generateRoutes,
    );
  }
}
