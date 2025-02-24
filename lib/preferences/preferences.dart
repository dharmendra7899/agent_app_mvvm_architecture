import 'dart:convert';
import 'package:agent_app/models/login_response_data_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

mixin Preferences {
  setToken(String token) async {
    debugPrint("STORED TOKEN::: $token");
    var pref = await SharedPreferences.getInstance();
    await pref.setString(KEYS.token.toString(), token);
  }

  setUserDetails(LoginData data) async {
    var pref = await SharedPreferences.getInstance();
    pref.setString(KEYS.userCredentials.toString(), jsonEncode(data.toJson()));
  }

  Future<String> getToken() async {
    var pref = await SharedPreferences.getInstance();
    var token = pref.getString(KEYS.token.toString());
    return token ?? '';
  }

  Future<LoginData?> getUserDetails() async {
    var pref = await SharedPreferences.getInstance();
    String? userDetailsJson = pref.getString(KEYS.userCredentials.toString());
    if (userDetailsJson != null) {
      return LoginData.fromJson(jsonDecode(userDetailsJson));
    }
    return null;
  }

  setWalkthrough() async {
    var pref = await SharedPreferences.getInstance();
    pref.setBool(KEYS.isWalkThrough.toString(), false);
  }

  Future<bool> isWalkthrough() async {
    var pref = await SharedPreferences.getInstance();
    return pref.getBool(KEYS.isWalkThrough.toString()) ?? true;
  }

  removeToken() async {
    var pref = await SharedPreferences.getInstance();
    pref.remove(KEYS.token.toString());
    pref.remove(KEYS.userCredentials.toString());
  }

  Future<void> saveUserCredentials(String userName, String password) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString(
      KEYS.userCredentials.toString(),
      jsonEncode({'userName': userName, 'password': password}),
    );
  }

  Future<Map<String, dynamic>> getUserCredentials() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String? data = pref.getString(KEYS.userCredentials.toString());
    if (data != null) {
      var userCredential = jsonDecode(data);
      return userCredential;
    }
    return {};
  }
}

enum KEYS { token, userCredentials, isWalkThrough }
