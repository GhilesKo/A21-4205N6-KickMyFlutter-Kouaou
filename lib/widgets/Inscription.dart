import 'package:flutter/material.dart';
import 'package:kickmyflutter/models/DTOs/SignupRequest.dart';

import '../services/auth_service.dart';

class Register extends StatefulWidget {
  const Register({Key? key, required this.onClickedSignIn})
      : super(key: key);
  final Function() onClickedSignIn;

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final password2Controller = TextEditingController();


  Future<void> _signUp() async {

    final SignupRequest request = SignupRequest( emailController.text, passwordController.text);
    try{
      await signUp(request);

    }catch(e){}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Register")),
      body: Column(
        children: [
          TextFormField(
            controller: emailController,
            decoration: const InputDecoration(hintText: 'Username'),
          ),
          TextFormField(
            controller: passwordController,
            decoration: const InputDecoration(hintText: 'Password'),
            obscureText: true,
          ),
          TextFormField(
            controller: password2Controller,
            decoration: const InputDecoration(hintText: 'Confirm Password'),
            obscureText: true,
          ),
          TextButton(
              onPressed: widget.onClickedSignIn, child: const Text("Login")),
          TextButton(onPressed: _signUp , child: const Text("Register")),
        ],
      ),
    );
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }


}
