import 'package:flutter/material.dart';
import 'package:login_final/models/user_model.dart';

class UserProvider extends ChangeNotifier {
  late UserModel? user;
  bool isLoged = false;
  List<UserModel> users = [];
  void login(UserModel user) {
    isLoged = true;
    user = user;
    print('provider login');
    notifyListeners();
  }

  void logout() {
    isLoged = false;
    user = null;
    notifyListeners();
  }

  void getAllUsers(List<UserModel> users) {
    this.users = users;
    notifyListeners();
  }
}
