import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:login_final/models/user_model.dart';
import 'package:login_final/provider/user_provider.dart';
import 'package:login_final/services/user_service.dart';
import 'package:provider/provider.dart';

class LoginPage extends HookWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final _formkey = useMemoized(() => GlobalKey<FormState>());
    final _password = useState('');
    final _email = useState('');
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Container(
        color: Colors.amber,
        child: Form(
          key: _formkey,
          child: ListView(
            children: <Widget>[
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 32),
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
                    _email.value = value!;
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 32),
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
                    _password.value = value!;
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 32,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          if (_formkey.currentState!.validate()) {
                            print('dentro del if');
                            _formkey.currentState!.save();
                            print(_email.value);
                            _submit(_email.value, _password.value, context);
                            print('llamado');
                          }
                        },
                        child: Text('Login')),
                    ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text('Go back'))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _submit(String email, String password, BuildContext ctx) async {
    print('email ----> $email');
    UserService _service = UserService();
    UserModel user =
        UserModel(id: null, username: null, email: email, password: password);
    try {
      print(user.toJson());
      user = await _service.login(user);
      Provider.of<UserProvider>(ctx, listen: false).login(user);
      Navigator.pop(ctx);
    } catch (error) {
      print(error);
    }
  }
}

// // Probar a usar el SingleChildScrollView si hay overflow en la pantalla por el formulario al aparecer el teclado
// class LoginPage extends StatefulWidget {
//   const LoginPage({super.key});

//   @override
//   State<LoginPage> createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   final _formKey = GlobalKey<FormState>();
//   String _password = '';
//   String _email = '';
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Login'),
//       ),
//       body: Container(
//         color: Colors.amber,
//         child: Center(
//           child: Column(
//             children: [
//               Expanded(
//                 flex: 6,
//                 child: Form(
//                     key: _formKey,
//                     child: ListView(
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 8),
//                           child: TextFormField(
//                             decoration: InputDecoration(labelText: 'Email'),
//                             validator: (value) {
//                               if (value == null || value.isEmpty) {
//                                 return 'Please enter your email';
//                               }
//                               if (!value.contains('@')) {
//                                 return 'Please enter a valid email address';
//                               }
//                               return null;
//                             },
//                             onSaved: (value) {
//                               _email = value!;
//                             },
//                           ),
//                         ),
//                         Padding(
//                           padding: EdgeInsets.symmetric(horizontal: 8),
//                           child: TextFormField(
//                             obscureText: true,
//                             decoration: InputDecoration(
//                               labelText: 'Password',
//                             ),
//                             validator: (value) {
//                               if (value == null || value.isEmpty) {
//                                 return 'Please enter your password';
//                               }

//                               return null;
//                             },
//                             onSaved: (value) {
//                               _password = value!;
//                             },
//                           ),
//                         ),
//                       ],
//                     )),
//               ),
//               Expanded(
//                 flex: 2,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     ElevatedButton(
//                         onPressed: () => Navigator.pop(context),
//                         child: Text('Login')),
//                     ElevatedButton(
//                         onPressed: () => Navigator.pop(context),
//                         child: Text('Go back'))
//                   ],
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
