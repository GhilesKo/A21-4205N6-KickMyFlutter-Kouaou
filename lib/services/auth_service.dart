import 'package:dio/dio.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:kickmyflutter/models/DTOs/SignupRequest.dart';
import 'package:kickmyflutter/models/SingletonDio.dart';

import '../models/DTOs/SigninResponse.dart';
import '../models/SingletonUser.dart';

Future<void> signUp(SignupRequest request) async {
  //Lance une requete pour signUp
  final response = await SingletonDio.getDio().post(
      'https://kickmyb-server.herokuapp.com/api/id/signup',
      data: request);

  SigninResponse signInResponse = SigninResponse.fromJson(response.data);
  SingletonUser.instance.username = signInResponse.username;

}
