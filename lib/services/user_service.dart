import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:login_final/models/login_model.dart';
import 'package:login_final/models/main_model.dart';
import 'package:login_final/models/user_model.dart';

class UserService {
  final baseUrl = 'http://localhost:7777';

  const UserService();

  Future<List<UserModel>> getAll() {
    throw Error;
  }

  Future<UserModel> register(UserModel user) async {
    final response = await http.post(Uri.parse('$baseUrl/register'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(user.toJson()));
    print(response.body);
    LoginModel mainResponse = LoginModel.fromJson(jsonDecode(response.body));
    return mainResponse.data;
  }
}
