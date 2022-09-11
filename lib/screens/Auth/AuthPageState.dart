import 'package:flutter/material.dart';
import 'package:kickmyflutter/screens/Auth/inscription.dart';
import 'package:kickmyflutter/screens/Auth/login.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isLogin = true;

  void toggle() => setState(() => isLogin = !isLogin);

  @override
  Widget build(BuildContext context) {
    if(isLogin){
      return LoginScreen(onClickedSignUp :toggle);
    }
    return RegisterScreen(onClickedSignIn:toggle);
  }
}
