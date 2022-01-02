import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../shared/models/auth_model.dart';
import '../shared/models/user_model.dart';
import '../utils/services/auth_service.dart';
import '../utils/services/dio_client.dart';
import '../utils/services/shared_prefs.dart';
import '../utils/services/user_service.dart';

class AuthProviderNotifier extends ChangeNotifier {
  ValueNotifier<UserModel> user = ValueNotifier(UserModel(
    id: '',
    email: '',
    lastName: '',
    updatedAt: '',
    createdAt: '',
    name: '',
  ));

  String token = '';

  bool authenticated = false;

  setAuth(AuthModel authData) async {
    storage.setData('@EzWallet: user', jsonEncode(authData.user.get()));
    storage.setData('@EzWallet: token', authData.token);
    user.value = authData.user;
    authenticated = true;
    user.notifyListeners();
  }

  getUser() async {
    try {
      final _authService = AuthService(dio);
      final storageData = await storage.getData('@EzWallet: user');
      if (storageData == '') {
        authenticated = false;
        return;
      }
      await getToken();
      final response = await _authService.loggedUser();
      user.value = response;
      authenticated = true;
      user.notifyListeners();
    } on DioError catch (e) {
      print(e.requestOptions.headers['Authorization']);
    }
  }

  getToken() async {
    final storageData = await storage.getData('@EzWallet: token');
    if (storageData == '') {
      authenticated = false;
      return;
    }
    final tokenDecoded = storageData as String;
    token = tokenDecoded;
    dio.dio.options.headers['Authorization'] = "Bearer $token";
    authenticated = true;
  }

  updateUser(dynamic data) async {
    try {
      final userService = UserService(dio);
      final response = await userService.updateUser(data);
      storage.setData('@EzWallet: user', jsonEncode(response.get()));
      user.value = response;
      user.notifyListeners();
    } on DioError catch (e) {
      print(e);
    }
  }

  logout(BuildContext context) async {
    await storage.removeData('@EzWallet: user');
    user.value = UserModel(
        id: '',
        email: '',
        lastName: '',
        updatedAt: '',
        createdAt: '',
        name: '');
    authenticated = false;
    user.notifyListeners();
    Navigator.of(context).pushReplacementNamed('/signin/');
  }
}