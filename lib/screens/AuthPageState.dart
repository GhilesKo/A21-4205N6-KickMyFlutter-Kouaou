import 'package:flutter/material.dart';
import 'package:kickmyflutter/widgets/Inscription.dart';
import 'package:kickmyflutter/widgets/Login.dart';

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
    
      return Login(onClickedSignUp :toggle);
    }
    return Register(onClickedSignIn:toggle);
  }

}
