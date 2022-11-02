import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:kickmyflutter/models/DTOs/requests/SignupRequest.dart';

import '../i18n/intl_localization.dart';
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
    if((email == "" || email==null) && (password == "" || password==null)){
    SnackBar snackBar = SnackBar(content: Text(Locs.of(context).trans('remplir')));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    setState(() => submitted = false);


    return;
    }
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
      setState(() => submitted = false);
      if (e.response == null) {
        final snackBar = SnackBar(content: Text(Locs.of(context).trans('internet')));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);

      return;
      }
      String msgErreur = e.response?.data;
      if (e.response?.data == "InternalAuthenticationServiceException") {
        msgErreur = Locs.of(context).trans('error');
      }
      if (e.response?.data == "BadCredentialsException") {
        msgErreur = Locs.of(context).trans('invalidcred');
      }
      final snackBar = SnackBar(content: Text(msgErreur));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }


  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Locs.of(context).trans('Connexion')),
      ),
      body: Column(
        children: [
          TextFormField(
            onChanged: (value) => email = value,
            decoration:  InputDecoration(hintText: Locs.of(context).trans('username')),
          ),
          TextFormField(
            onChanged: (value) => password = value,
            decoration:  InputDecoration(hintText: Locs.of(context).trans('password')),
            obscureText: true,
          ),
          TextButton(
              onPressed: !submitted ? _signIn : null,
              child:  Text(Locs.of(context).trans('Connexion'))),
          TextButton(
              onPressed: !submitted ? widget.onClickedSignUp : null,
              child:  Text(Locs.of(context).trans('Register'))),
        ],
      ),
    );
  }
}
