import 'dart:convert';

import 'user_model.dart';

class LoginModel {
  final String message;
  final UserModel data;
  const LoginModel({required this.message, required this.data});

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
        message: json['message'],
        // data: dataJson.map((user) => UserModel.fromJson(user)).toList())
        data: UserModel.fromJson(json['data']));
  }
}
