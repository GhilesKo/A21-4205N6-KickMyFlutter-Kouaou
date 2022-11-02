import 'package:flutter/material.dart';
import 'package:kickmyflutter/models/SingletonUser.dart';
import 'package:kickmyflutter/screens/AuthStatePage.dart';
import 'package:kickmyflutter/screens/CreationPage.dart';
import 'package:kickmyflutter/screens/HomePage.dart';
import 'package:kickmyflutter/services/auth_service.dart';

import '../i18n/intl_localization.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
bool loading = false;
  void setLoading(bool state) {
    setState(() => loading = state);
  }


Future<void> _signOut() async {

  await signOut();
  if (mounted) {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (context) => const AuthStatePage()),
                    (Route<dynamic> route) => false);
              }
  SingletonUser.instance.username = null;


}
_toggleSignOut() async{
  try {
    setLoading(true);
    await _signOut();
  } finally {
    setLoading(false);

  }
}

  @override
  Widget build(BuildContext context) {
  return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
              accountName:(SingletonUser.instance.username !=null)? Text(SingletonUser.instance.username!): Text(""),
              accountEmail: (SingletonUser.instance.username !=null)?
                  Text("${SingletonUser.instance.username!}@gmail.com"):Text(""),
              currentAccountPicture: Image.network(
                  "https://cdn-icons-png.flaticon.com/512/3135/3135715.png")),
          ListTile(
            leading: Icon(Icons.home),
            title: Text(Locs.of(context).trans('home')),
            onTap: () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const HomePage()),
                  (Route<dynamic> route) => false);
            },
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text(Locs.of(context).trans('add')),
            onTap: () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const AddTaskPage()),
                  (Route<dynamic> route) => false);
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout_outlined),
            title:  Text(Locs.of(context).trans('loggout')),
            enabled: !loading,
            onTap: !loading ? _toggleSignOut : null,

          ),
        ],
      ),
    );
  }
}
