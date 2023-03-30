import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:login_final/pages/main_page.dart';
import 'package:login_final/provider/user_provider.dart';
import 'package:provider/provider.dart';

class RegisteredUserPage extends StatelessWidget {
  const RegisteredUserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Dashboard"),
      ),
      body: Container(
        child: Center(
          child: Column(
            children: [
              Text('Registrado'),
              ElevatedButton(
                  onPressed: () {
                    context.read<UserProvider>().logout();
                    // Navigator.pushReplacement(context,
                    //     MaterialPageRoute(builder: (context) => MainPage()));
                  },
                  child: Text('Volver'))
            ],
          ),
        ),
      ),
    );
  }
}
