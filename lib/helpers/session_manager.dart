import 'dart:convert';
import 'package:agent_app/modules/auth/model/login_response_data_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract interface class SessionManager {
  Future<void> setToken(String token);

  Future<String> getToken();

  Future<LoginData> getSession();

  Future<void> setSession(LoginData userData);

  Future<void> setWalkThrough();

  Future<bool> isWalkThrough();

  Future<void> clearSession();
}

class SessionManagerImp implements SessionManager {
  final SharedPreferences sharedPreferences;
  SessionManagerImp({required this.sharedPreferences});

  @override
  Future<LoginData> getSession() async {
    var data = sharedPreferences.getString(Keys.USERDETAILS.toString());
    if (data != null) {
      return LoginData.fromJson(jsonDecode(data));
    }
    return LoginData();
  }

  @override
  Future<void> setSession(LoginData userData) async {
    await sharedPreferences.setString(
        Keys.USERDETAILS.toString(), jsonEncode(userData.toJson()));
  }

  @override
  Future<void> setWalkThrough() async {
    sharedPreferences.setBool(Keys.WALKTHROUGH.toString(), false);
  }

  @override
  Future<bool> isWalkThrough() async {
    return sharedPreferences.getBool(Keys.WALKTHROUGH.toString()) ?? true;
  }

  @override
  Future<String> getToken() async {
    return sharedPreferences.getString(Keys.TOKEN.toString()) ?? '';
  }

  @override
  Future<void> setToken(String token) async {
    sharedPreferences.setString(Keys.TOKEN.toString(), token);
  }

  @override
  Future<void> clearSession() async {
    sharedPreferences.remove(Keys.TOKEN.toString());
    sharedPreferences.remove(Keys.USERDETAILS.toString());
  }
}

enum Keys {USERDETAILS, WALKTHROUGH, TOKEN}
