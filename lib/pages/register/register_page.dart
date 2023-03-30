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
  const RegisterPage({super.key});
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
        title: Text('Sign up'),
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
                          _submitForm(context);
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

  Future<void> _submitForm(BuildContext ctx) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      UserModel user = UserModel(
          id: null, username: _username, email: _email, password: _password);
      final services = UserService();
      try {
        UserModel login = await services.register(user);
        print('LLamando al provider');
        UserProvider userProvider =
            Provider.of<UserProvider>(context, listen: false);
        userProvider.login(login);
        // Navigator.of(context).push(MaterialPageRoute(
        //     builder: (context) => const RegisteredUserPage()));
        // Navigator.pushReplacement(context,
        //     MaterialPageRoute(builder: (context) => RegisteredUserPage()));
        Navigator.pop(ctx);
      } catch (e) {
        print('Error al hacer la llamada $e');
        print(e.toString());
        // _showCupertinoSimpleDialog(e.toString());
        _showSimpleDialog(e.toString());
      }
    }
  }

  Future<void> _showCupertinoSimpleDialog(String msg) {
    return showDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text('Error en la peticion'),
            content: Text('Mensaje del error $msg'),
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

  Future<void> _showSimpleDialog(String message) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Error en la peticion'),
            content: Text('Mensaje del error $message'),
            actions: <Widget>[
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
