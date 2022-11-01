import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:kickmyflutter/models/DTOs/requests/SignupRequest.dart';
import 'package:kickmyflutter/screens/HomePage.dart';

import '../i18n/intl_localization.dart';
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
    setState(() => submitted = true);
    if (_password != _password2) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Les mots de passes ne correspondent pas ")));
    } else {
      final SignupRequest request = SignupRequest(_email, _password);
      try {
        await signUp(request);
        if (mounted) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const HomePage()),
          );
        }
      } on DioError catch (e) {
        final snackBar = SnackBar(content: Text(e.response?.data));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }
    setState(() => submitted = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:  Text(Locs.of(context).trans('Register'))),
      body: Column(
        children: [
          //Email TextField
          TextFormField(
            onChanged: (value) => _email = value,
            decoration:  InputDecoration(hintText: Locs.of(context).trans('username')),
          ),
          TextFormField(
            onChanged: (value) => _password = value,
            decoration:  InputDecoration(hintText: Locs.of(context).trans('password')),
            obscureText: true,
          ),
          TextFormField(
            onChanged: (value) => _password2 = value,
            decoration:  InputDecoration(hintText: Locs.of(context).trans('confirm')),
            obscureText: true,
          ),
          TextButton(
              onPressed: !submitted ? _signUp : null,
              child:  Text(Locs.of(context).trans('Register'))),
          TextButton(
              onPressed: !submitted ? widget.onClickedSignIn : null,
              child:  Text(Locs.of(context).trans('Inscription'))),

        ],
      ),
    );
  }
}
