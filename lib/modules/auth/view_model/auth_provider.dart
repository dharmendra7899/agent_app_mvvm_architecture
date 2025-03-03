import 'package:agent_app/helpers/session_manager.dart';
import 'package:agent_app/modules/auth/model/login_response_data_model.dart';
import 'package:agent_app/modules/auth/repository/auth_repository.dart';
import 'package:agent_app/network/response_model.dart';
import 'package:agent_app/utils/routes/routes_names.dart';
import 'package:agent_app/utils/utils.dart';
import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  final AuthRepository authRepo;
  final SessionManager sessionManager;

  AuthProvider({required this.authRepo, required this.sessionManager}) {
    sessionManager.getSession().then((value) {
      _userData = value;
    });
  }

  bool _showLoader = false;

  bool get showLoader => _showLoader;
  bool _isShowNewPassword = false;

  get isShowNewPassword => _isShowNewPassword;

  LoginData _userData = LoginData();

  LoginData get userData => _userData;

  void updatePasswordStatus(bool value) {
    _isShowNewPassword = value;
    notifyListeners();
  }

  _setShowLoader(bool value) {
    _showLoader = value;
    notifyListeners();
  }

  login({
    String? email,
    String? password,
    required BuildContext context,
    String? accessToken,
    String? name,
  }) async {
    _setShowLoader(true);
    var res = await authRepo.login(email: email!, password: password!);
    res.fold(
      (String message) {
        Utils.flushBarErrorMessage(message, context);

        _setShowLoader(false);
        notifyListeners();
      },
      (ResponseModel response) {
        _userData = LoginData.fromJson(
          response.data['oldUser'] ?? response.data['resultDoc'],
        );
        sessionManager.setSession(_userData);
        sessionManager.setToken(
          response.data['token'] ?? response.data['tokens'],
        );
        _setShowLoader(false);
        Utils.toastMessage(context, message: response.message ?? "");
        Navigator.popAndPushNamed(context, RouteNames.bottomNavigationScreen);

        notifyListeners();
      },
    );
  }

  signUp({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
    required BuildContext context,
  }) async {
    _setShowLoader(true);
    var res = await authRepo.signUp(
      name: name,
      email: email,
      password: password,
      confirmPassword: confirmPassword,
    );
    res.fold(
      (String message) {
        Utils.flushBarErrorMessage(message, context);

        _setShowLoader(false);
      },
      (String message) {
        _setShowLoader(false);
        //otp screen
        Utils.toastMessage(context, message: message);
        // Navigator.pushNamed(context, RouteNames.login);
      },
    );
  }

  validateNavigation(BuildContext context) {
    sessionManager.isWalkThrough().then((value) {
      if (value) {
        if (context.mounted) {
          //walkthrough
          Navigator.pushNamed(context, RouteNames.walkThroughScreen);
        }
      } else {
        sessionManager.getToken().then((value) {
          if (value.isEmpty) {
            if (context.mounted) {
              Navigator.pushNamed(context, RouteNames.login);
            }
          } else {
            if (context.mounted) {
              Navigator.popAndPushNamed(
                context,
                RouteNames.bottomNavigationScreen,
              );
            }
          }
        });
      }
    });
  }

  setWalkThrough(BuildContext context) {
    sessionManager.setWalkThrough().then((value) {
      if (context.mounted) {
        Navigator.pushNamed(context, RouteNames.login);
      }
    });
  }

  logout(BuildContext context) async {
    sessionManager.clearSession();
    Navigator.pushNamed(context, RouteNames.login);
  }
}
