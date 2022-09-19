import 'package:flutter/material.dart';
import 'package:kickmyflutter/widgets/Inscription.dart';
import 'package:kickmyflutter/widgets/Login.dart';

class AuthStatePage extends StatefulWidget {
  const AuthStatePage({Key? key}) : super(key: key);

  @override
  State<AuthStatePage> createState() => _AuthStatePageState();
}

class _AuthStatePageState extends State<AuthStatePage> {
  bool isLogin = true;

  void toggle() => setState(() => isLogin = !isLogin);

  @override
  Widget build(BuildContext context) {
    if (isLogin) {
      return Login(onClickedSignUp: toggle);
    }
    return Register(onClickedSignIn: toggle);
  }
}
