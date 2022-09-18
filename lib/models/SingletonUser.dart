

class SingletonUser {

  String? username;

  static final SingletonUser _singleton = SingletonUser._internal();
  factory SingletonUser() => _singleton;
  SingletonUser._internal();

  static SingletonUser get instance => _singleton;





}