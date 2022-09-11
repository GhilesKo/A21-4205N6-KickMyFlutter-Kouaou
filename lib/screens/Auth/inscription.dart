import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key, required this.onClickedSignIn}) : super(key: key);
  final Function() onClickedSignIn;
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final password2Controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Register")
      ),
      body: Column(
        children: [
          TextFormField(
            controller: emailController,
            decoration: InputDecoration(hintText: 'Username'),

          ),
          TextFormField(
              controller: passwordController,
              decoration:  InputDecoration(hintText: 'Password'),
              obscureText: true,

          ), TextFormField(
              controller: password2Controller,
              decoration: InputDecoration(hintText: 'Confirm Password'),
              obscureText: true,


          ),
          TextButton(onPressed: widget.onClickedSignIn, child: const Text("Login")),
          TextButton(onPressed: ()=>{}, child: const Text("Register")),

        ],
      ) ,
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
