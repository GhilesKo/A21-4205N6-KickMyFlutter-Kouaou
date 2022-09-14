import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:kickmyflutter/models/DTOs/SignupRequest.dart';
import 'package:kickmyflutter/screens/HomePage.dart';

import '../services/auth_service.dart';

class Register extends StatefulWidget {
  const Register({Key? key, required this.onClickedSignIn}) : super(key: key);
  final Function() onClickedSignIn;

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String _email = '';
  String _password = '';
  String _password2 = '';
  bool submitted = false;

  Future<void> _signUp() async {
    setState(() {
      submitted = true;
    });
    final SignupRequest request = SignupRequest(_email, _password);
    try {
      await signUp(request);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    } on DioError catch (e) {
      final snackBar = SnackBar(content: Text(e.response?.data));

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    setState(() {
      submitted = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Register")),
      body: Column(
        children: [
          //Email TextField
          TextFormField(
            onChanged: (value) => _email = value,
            decoration: const InputDecoration(hintText: 'Username'),
          ),
          TextFormField(
            onChanged: (value) => _password = value,
            decoration: const InputDecoration(hintText: 'Password'),
            obscureText: true,
          ),
          TextFormField(
            onChanged: (value) => _password2 = value,
            decoration: const InputDecoration(hintText: 'Confirm Password'),
            obscureText: true,
          ),
          TextButton(
              onPressed: widget.onClickedSignIn, child: const Text("Login")),
          TextButton(
              onPressed: !submitted ? _signUp : null,
              child: const Text("Register")),
        ],
      ),
    );
  }
}
