import 'package:agent_app/utils/routes/routes_names.dart' show RouteNames;
import 'package:agent_app/viewModel/user_view_model.dart' show UserViewModel;
import 'package:flutter/material.dart';

class SplashService {
  static void checkAuthentication(BuildContext context) async {
    final userViewModel = UserViewModel();
    final user = await userViewModel.getUser();

    if (user!.token.toString() == "null" || user.token.toString() == "") {
      await Future.delayed(const Duration(seconds: 4));
      if (context.mounted) {
        Navigator.pushNamed(context, RouteNames.login);
      }
    } else {
      await Future.delayed(const Duration(seconds: 3));
      if (context.mounted) {
        // Navigator.pushNamed(context, RouteNames.home);
      }
    }
  }
}
