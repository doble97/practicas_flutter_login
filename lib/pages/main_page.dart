import 'package:flutter/material.dart';
import 'package:login_final/models/user_model.dart';
import 'package:login_final/pages/login/login_page.dart';
import 'package:login_final/pages/register/register_page.dart';
import 'package:login_final/pages/registered_user/user_in_page.dart';
import 'package:login_final/provider/user_provider.dart';
import 'package:provider/provider.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return NotRegisteredWidget(title: 'Main');
  }
}

class NotRegisteredWidget extends StatelessWidget {
  const NotRegisteredWidget({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(title),
      ),
      body: Container(
        color: Colors.amber,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () {
                    // Navigator.of(context).push(MaterialPageRoute(
                    //     builder: (context) => const RegisterPage(
                    //           onCallback: (UserModel user){onChangeState(user)},
                    //         )));
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => RegisterPage()));
                  },
                  child: Text('Register')),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const LoginPage()));
                  },
                  child: Text('Login')),
            ],
          ),
        ),
      ),
    );
  }
}
