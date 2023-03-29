import 'package:flutter/material.dart';
import 'package:login_final/models/user_model.dart';

class UserProvider extends ChangeNotifier {
  late UserModel? user;
  List<UserModel> users = [];
  void login(UserModel user) {
    user = user;
    notifyListeners();
  }

  void logout() {
    user = null;
    notifyListeners();
  }

  void getAllUsers(List<UserModel> users) {
    this.users = users;
    notifyListeners();
  }
}
