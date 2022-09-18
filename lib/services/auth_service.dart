import 'package:dio/dio.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:kickmyflutter/models/DTOs/HomeItemResponse.dart';
import 'package:kickmyflutter/models/DTOs/SignupRequest.dart';
import 'package:kickmyflutter/models/SingletonDio.dart';

import '../models/DTOs/SigninResponse.dart';
import '../models/SingletonUser.dart';

Future<void> signUp(SignupRequest request) async {
  //Lance une requete pour signUp
  // 'https://kickmyb-server.herokuapp.com/api/id/signup'
  final response = await SingletonDio.getDio()
      .post('http://10.0.2.2:8080/api/id/signup', data: request);

  SigninResponse signInResponse = SigninResponse.fromJson(response.data);
  SingletonUser.instance.username = signInResponse.username;
}

Future<void> signIn(SignupRequest request) async {
  //Lance une request pour signIn
  // 'https://kickmyb-server.herokuapp.com/api/id/signin'
  final response = await SingletonDio.getDio()
      .post('http://10.0.2.2:8080/api/id/signin', data: request);

  SigninResponse signInResponse = SigninResponse.fromJson(response.data);
  SingletonUser.instance.username = signInResponse.username;
}


Future<List<HomeItemResponse>> getTask() async {

  //Lance une request pour getTask
  // 'https://kickmyb-server.herokuapp.com/api/home'
  final response = await SingletonDio.getDio().get('http://10.0.2.2:8080/api/home');
  List<HomeItemResponse> tasks = [];
  for (var task in response.data ) {
   HomeItemResponse item = HomeItemResponse.fromJson(task);
   tasks.add(item);
  }

  return tasks;
}