import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

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
                    exit(0);
                  },
                  child: Text('Volver'))
            ],
          ),
        ),
      ),
    );
  }
}
