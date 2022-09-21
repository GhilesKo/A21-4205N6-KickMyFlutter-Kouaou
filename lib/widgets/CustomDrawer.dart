import 'package:flutter/material.dart';
import 'package:kickmyflutter/models/SingletonUser.dart';
import 'package:kickmyflutter/screens/AuthStatePage.dart';
import 'package:kickmyflutter/screens/CreationPage.dart';
import 'package:kickmyflutter/screens/HomePage.dart';
import 'package:kickmyflutter/services/auth_service.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
              accountName: Text(SingletonUser.instance.username!),
              accountEmail:
                  Text("${SingletonUser.instance.username!}@gmail.com"),
              currentAccountPicture: Image.network(
                  "https://cdn-icons-png.flaticon.com/512/3135/3135715.png")),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Accueil'),
            onTap: () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const HomePage()),
                  (Route<dynamic> route) => false);
            },
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Ajout de tâche'),
            onTap: () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const AddTaskPage()),
                  (Route<dynamic> route) => false);
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout_outlined),
            title: const Text('Déconnexion'),
            onTap: () async {
              await signOut();
              if (mounted) {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (context) => const AuthStatePage()),
                    (Route<dynamic> route) => false);
              }
            },
          ),
        ],
      ),
    );
  }
}
