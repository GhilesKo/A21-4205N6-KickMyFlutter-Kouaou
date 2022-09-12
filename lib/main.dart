import 'package:flutter/material.dart';
import 'package:kickmyflutter/screens/AuthPageState.dart';
import 'package:kickmyflutter/widgets/Login.dart';
import 'package:kickmyflutter/screens/HomePage.dart';
import 'package:provider/provider.dart';

import 'models/User.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<UserModel>.value(
      value: UserModel(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Wrapper(),
      ),
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
          return const AuthPage();
        } else {
          return const HomePage();
        }
      },
    );
  }
}
