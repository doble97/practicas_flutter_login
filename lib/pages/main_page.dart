import 'package:flutter/material.dart';
import 'package:login_final/models/user_model.dart';
import 'package:login_final/pages/register/register_page.dart';
import 'package:login_final/pages/registered_user/user_in_page.dart';
import 'package:login_final/provider/user_provider.dart';
import 'package:provider/provider.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, userProvider, _) {
        if (userProvider.isLoged) {
          print('Consumer .... if');
          return RegisteredUserPage();
        } else {
          print('Consumer .... else');

          return NotRegisteredWidget(
            title: 'Register',
            onChangeState: (UserModel user) {
              userProvider.login(user);
            },
          );
        }
      },
    );
  }
}

class NotRegisteredWidget extends StatelessWidget {
  final Function(UserModel user) onChangeState;
  const NotRegisteredWidget(
      {super.key, required this.title, required this.onChangeState});

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
                        builder: (context) =>
                            RegisterPage(onCallback: (UserModel user) {
                              onChangeState(user);
                            })));
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
