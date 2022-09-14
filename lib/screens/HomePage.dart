import 'package:flutter/material.dart';
import 'package:kickmyflutter/models/SingletonUser.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) =>
      Scaffold(
        appBar: AppBar(
          title: Text("Hello ${SingletonUser.instance.username}"),
        ),
        body: const Center(
          child: Text("Bienvenue"),
        ),
      );
}
