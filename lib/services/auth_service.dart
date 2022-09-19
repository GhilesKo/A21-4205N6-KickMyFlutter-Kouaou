import 'package:kickmyflutter/models/DTOs/responses/HomeItemResponse.dart';
import 'package:kickmyflutter/models/DTOs/requests/SignupRequest.dart';
import 'package:kickmyflutter/models/SingletonDio.dart';

import '../models/DTOs/responses/SigninResponse.dart';
import '../models/SingletonUser.dart';

Future<void> signUp(SignupRequest request) async {
  //Lance une requete pour signUp
  // 'http://10.0.2.2:8080/api/id/signup'
  final response = await SingletonDio.getDio().post(
      'https://kickmyb-server.herokuapp.com/api/id/signup',
      data: request);

  SigninResponse signInResponse = SigninResponse.fromJson(response.data);
  SingletonUser.instance.username = signInResponse.username;
}

Future<void> signIn(SignupRequest request) async {
  //Lance une request pour signIn
  // http://10.0.2.2:8080/api/id/signin
  final response = await SingletonDio.getDio().post(
      'https://kickmyb-server.herokuapp.com/api/id/signin',
      data: request);

  SigninResponse signInResponse = SigninResponse.fromJson(response.data);
  SingletonUser.instance.username = signInResponse.username;
}

Future<List<HomeItemResponse>> getTask() async {
  //Lance une request pour getTask
  // 'http://10.0.2.2:8080/api/home'
  final response =
      await SingletonDio.getDio().get('https://kickmyb-server.herokuapp.com/api/home');
  List<HomeItemResponse> tasks = [];
  for (var task in response.data) {
    HomeItemResponse item = HomeItemResponse.fromJson(task);
    tasks.add(item);
  }

  return tasks;
}
