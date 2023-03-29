import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:login_final/pages/register/register_page.dart';

class MainPage extends StatelessWidget {
  final String title;
  const MainPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const RegisterPage()));
                  },
                  child: Text('Register')),
              ElevatedButton(onPressed: null, child: Text('Login')),
            ],
          ),
        ),
      ),
    );
  }
}
