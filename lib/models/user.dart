import 'package:flutter/material.dart';

class User {
  String username;

  User(this.username);

/*  User.fromJson(Map<String, dynamic> json) {
    username = json['username'];
  }*/
}

class UserModel extends ChangeNotifier {
  User? _user;

  User? get user => _user;

  set user(User? value) {
    _user = value;
    //here the model value changes. you can call 'notifyListeners' to notify all the 'Consumer<UserModel>'
    notifyListeners();
  }
}
