import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:login_final/interfaces/i_api.dart';
import 'package:login_final/models/login_model.dart';
import 'package:login_final/models/main_model.dart';
import 'package:login_final/models/user_model.dart';

class UserService implements IApi<UserModel> {
  final baseUrl = 'http://localhost:7777';

  const UserService();

  @override
  Future<UserModel> register(UserModel user) async {
    final response = await http.post(Uri.parse('$baseUrl/register'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(user.toJson()));
    print(response.body);
    LoginModel mainResponse = LoginModel.fromJson(jsonDecode(response.body));
    return mainResponse.data;
  }

  @override
  Future<List<UserModel>> getAll() async {
    final response = await http.get(Uri.parse('$baseUrl/all'));
    MainResponse mainResponse =
        MainResponse.fromJson(jsonDecode(response.body));
    return mainResponse.data;
  }

  @override
  Future<UserModel> login(UserModel value) async {
    try {
      final response = await http.post(Uri.parse('$baseUrl/login'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(value.toJson()));
      if (response.statusCode == 401) {
        throw Exception('Error de credenciales');
      }
      LoginModel login = LoginModel.fromJson(jsonDecode(response.body));
      return login.data;
    } catch (e) {
      print(e.toString());
      throw Exception('Error en la conexion');
    }
  }
}
