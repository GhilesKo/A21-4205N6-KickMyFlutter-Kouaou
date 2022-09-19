import 'package:flutter/material.dart';
import 'package:kickmyflutter/models/SingletonUser.dart';
import 'package:kickmyflutter/screens/AuthStatePage.dart';
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
          const ListTile(
            leading: Icon(Icons.home),
            title: Text('home'),
          ),
          ListTile(
            leading: const Icon(Icons.logout_outlined),
            title: const Text('logout'),
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
