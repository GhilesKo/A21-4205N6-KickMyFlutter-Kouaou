import 'package:kickmyflutter/models/DTOs/SignupRequest.dart';
import 'package:kickmyflutter/models/SingletonDio.dart';

Future<void> signUp(SignupRequest request) async {
  try {
    final response =
        await SingletonDio.getDio().post('https://kickmyb-server.herokuapp.com/api/id/signup', data: request);

    print(response);
  } catch (e) {
    print(e);
    throw (e);
  }
}
