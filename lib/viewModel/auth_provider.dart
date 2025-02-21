import 'package:agent_app/models/user_model.dart' show UserModel;
import 'package:agent_app/repository/auth_repository.dart' show AuthRepository;
import 'package:agent_app/utils/utils.dart' show Utils;
import 'package:agent_app/viewModel/user_view_model.dart' show UserViewModel;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthViewModel with ChangeNotifier {
  final _auth = AuthRepository();

  bool _loginLoading = false;
  bool _signupLoading = false;

  get loading => _loginLoading;

  get signupLoading => _signupLoading;

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
        .then((value) {
          setLoginLoading(false);
          if (context.mounted) {
            final userPreference = Provider.of<UserViewModel>(
              context,
              listen: false,
            );
            userPreference.saveUser(
              UserModel(token: value['token'].toString()),
            );
            Utils.toastMessage(message: "Login Successful", context);
            //Navigator.pushNamed(context, RouteNames.home);
          }
        })
        .onError((error, stackTrace) {
          if (context.mounted) {
            Utils.flushBarErrorMessage(error.toString(), context);
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
