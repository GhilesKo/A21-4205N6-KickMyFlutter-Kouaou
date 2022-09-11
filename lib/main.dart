import 'package:flutter/material.dart';
import 'package:kickmyflutter/screens/Auth/AuthPageState.dart';
import 'package:kickmyflutter/screens/Auth/login.dart';
import 'package:kickmyflutter/screens/HomePage.dart';
import 'package:provider/provider.dart';

import 'models/user.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: const AuthPage(),
    );
  }
}

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //return either home or authenticate widget
    return Consumer<UserModel>(
      builder: (context, userModel, child) {
        if (userModel.user == null) {
          return AuthPage();
        } else {
          return HomePage();
        }
      },
    );
  }
}



