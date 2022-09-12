import 'package:flutter/material.dart';



class Login extends StatefulWidget {
  const Login({Key? key, required this.onClickedSignUp}) : super(key: key);

  final Function() onClickedSignUp;

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
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
