import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:login_final/models/login_model.dart';
import 'package:login_final/models/user_model.dart';
import 'package:login_final/pages/registered_user/user_in_page.dart';
import 'package:login_final/provider/user_provider.dart';
import 'package:login_final/services/user_service.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  final Function(UserModel) onCallback;
  const RegisterPage({super.key, required this.onCallback});
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  String _password = '';
  String _email = '';
  String _username = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register user'),
      ),
      body: Container(
        child: Center(
          child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Username',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your username';
                        }

                        return null;
                      },
                      onSaved: (value) {
                        _username = value!;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: TextFormField(
                      decoration: InputDecoration(labelText: 'Email'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        if (!value.contains('@')) {
                          return 'Please enter a valid email address';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _email = value!;
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Password',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }

                        return null;
                      },
                      onSaved: (value) {
                        _password = value!;
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          _submitForm();
                        },
                        child: Text('Register'),
                      ),
                      ElevatedButton(
                        onPressed: () => {Navigator.pop(context)},
                        child: Text('Go back'),
                      ),
                    ],
                  )
                ],
              )),
        ),
      ),
    );
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      UserModel user = UserModel(
          id: null, username: _username, email: _email, password: _password);
      final services = UserService();
      try {
        UserModel login = await services.register(user);
        print('LLamando al provider');
        widget.onCallback(login);
        // Navigator.of(context).push(MaterialPageRoute(
        //     builder: (context) => const RegisteredUserPage()));
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => RegisteredUserPage()));
      } catch (e) {
        print('Error al hacer la llamada $e');
        print(e.toString());
        _showSimpleDialog(e.toString());
      }
    }
  }

  void _showCupertinoSimpleDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text('Cupertino Dialog'),
            content: Text('Hey! I am Coflutter!'),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Close')),
            ],
          );
        });
  }

  void _showSimpleDialog(String message) {
    showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: Text(message),
            children: <Widget>[
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('close'),
                    ),
                  ],
                ),
              ),
            ],
          );
        });
  }
}
