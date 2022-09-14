import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:kickmyflutter/models/DTOs/SignupRequest.dart';

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
    setState(()=>submitted = true);
    SignupRequest signupRequest = SignupRequest(email, password);
    try {
      await signIn(signupRequest);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    } on DioError catch (e) {
      final snackBar = SnackBar(content: Text(e.response?.data));

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    setState(()=>submitted = false);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Column(
        children: [
          TextFormField(
            onChanged: (value) => email = value,
            decoration: new InputDecoration(hintText: 'Username'),
          ),
          TextFormField(
            onChanged: (value) => password = value,
            decoration: new InputDecoration(hintText: 'Password'),
            obscureText: true,
          ),
          TextButton(onPressed:  !submitted ? _signIn : null, child: const Text("Login")),
          TextButton(
              onPressed: !submitted ? widget.onClickedSignUp : null, child: const Text("Register")),
        ],
      ),
    );
  }
}
