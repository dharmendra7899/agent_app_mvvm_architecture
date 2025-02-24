import 'dart:convert';

import 'package:agent_app/models/login_response_data_model.dart';
import 'package:agent_app/preferences/preferences.dart';
import 'package:agent_app/repository/auth_repository.dart' show AuthRepository;
import 'package:agent_app/utils/utils.dart' show Utils;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthViewModel extends ChangeNotifier with Preferences {
  final _auth = AuthRepository();

  late final SharedPreferences _preferences;
  String? _token = '';

  String? get token => _token;
  LoginData _login = LoginData();

  LoginData get login => _login;

  AuthViewModel(this._preferences) {
    _token = _preferences.getString(KEYS.token.toString()) ?? '';
    var userDetails =
        _preferences.getString(KEYS.userCredentials.toString()) ?? '';
    debugPrint("user details--->$userDetails");
    debugPrint("TOKEN--->$token");
    if (userDetails == '') {
    } else {
      Map<String, dynamic> userDetail = jsonDecode(userDetails);
      _login = LoginData.fromJson(userDetail);
    }
  }

  bool _loginLoading = false;
  bool _signupLoading = false;
  bool _isShowNewPassword = false;

  get loading => _loginLoading;

  get signupLoading => _signupLoading;

  get isShowNewPassword => _isShowNewPassword;

  void updatePasswordStatus(bool value) {
    _isShowNewPassword = value;
    notifyListeners();
  }

  @override
  void dispose() {
    updatePasswordStatus(false);
    super.dispose();
  }

  void setLoginLoading(bool value) {
    _loginLoading = value;
    notifyListeners();
  }

  void setSignUpLoading(bool value) {
    _signupLoading = value;
    notifyListeners();
  }

  Future<void> apiLogin(dynamic data, BuildContext context) async {
    setLoginLoading(true);
    _auth
        .apiLogin(data)
        .then((value) async {
          setLoginLoading(false);
          _login = LoginData.fromJson(data);
          if (context.mounted) {
            await setUserDetails(_login);
            await setToken(_login.token ?? '');
            if (context.mounted) {
              Utils.toastMessage(message: "Login Successful", context);
            }
            //Navigator.pushNamed(context, RouteNames.home);
          }
        })
        .onError((error, stackTrace) {
          debugPrint("3487657846845 :::  ${error.toString()}");
          if (context.mounted) {
            // Utils.flushBarErrorMessage(error.toString(), context);
          }
          setLoginLoading(false);
        });
  }

  Future<void> apiSignUp(dynamic data, BuildContext context) async {
    setSignUpLoading(true);
    _auth
        .signUp(data)
        .then((value) {
          if (context.mounted) {
            Utils.flushBarErrorMessage("Sign Up Successful", context);

            // Navigator.pushNamed(context, RouteNames.home);
          }
          setSignUpLoading(false);
        })
        .onError((error, stackTrace) {
          if (context.mounted) {
            Utils.flushBarErrorMessage(error.toString(), context);
          }
          setSignUpLoading(false);
        });
  }
}
