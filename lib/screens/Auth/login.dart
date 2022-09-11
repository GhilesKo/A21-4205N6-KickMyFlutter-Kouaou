import 'package:flutter/material.dart';



class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key, required this.onClickedSignUp}) : super(key: key);

  final Function() onClickedSignUp;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Login"),

      ),
      body: Column(
        children: [
          TextFormField(
            controller: emailController,
          decoration: new InputDecoration(hintText: 'Username'),

          ),
          TextFormField(
              controller: passwordController,
              decoration: new InputDecoration(hintText: 'Password'),
              obscureText: true,
            
          ),
          TextButton(onPressed: (){}, child: const Text("Login")),
          TextButton(onPressed: widget.onClickedSignUp, child: const Text("Register")),

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
