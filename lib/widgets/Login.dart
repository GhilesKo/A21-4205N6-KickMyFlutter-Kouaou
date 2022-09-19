import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:kickmyflutter/models/DTOs/requests/SignupRequest.dart';

import '../screens/HomePage.dart';
import '../services/auth_service.dart';

class Login extends StatefulWidget {
  const Login({Key? key, required this.onClickedSignUp}) : super(key: key);

  final Function() onClickedSignUp;

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String email = '';
  String password = '';
  bool submitted = false;

  Future<void> _signIn() async {
    setState(() => submitted = true);
    SignupRequest signupRequest = SignupRequest(email, password);
    try {
      await signIn(signupRequest);
      if (mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      }
    } on DioError catch (e) {
      String msgErreur = e.response?.data;

      if (e.response?.data == "InternalAuthenticationServiceException") {
        msgErreur = "Nom d'utilisateur invalide";
      }
      if (e.response?.data == "BadCredentialsException") {
        msgErreur = "Mot de passe invalide";
      }
      final snackBar = SnackBar(content: Text(msgErreur));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    setState(() => submitted = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: Column(
        children: [
          TextFormField(
            onChanged: (value) => email = value,
            decoration: const InputDecoration(hintText: 'Username'),
          ),
          TextFormField(
            onChanged: (value) => password = value,
            decoration: const InputDecoration(hintText: 'Password'),
            obscureText: true,
          ),
          TextButton(
              onPressed: !submitted ? _signIn : null,
              child: const Text("Login")),
          TextButton(
              onPressed: !submitted ? widget.onClickedSignUp : null,
              child: const Text("Register")),
        ],
      ),
    );
  }
}
