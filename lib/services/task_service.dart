import 'package:kickmyflutter/models/DTOs/requests/AddTaskRequest.dart';
import 'package:kickmyflutter/models/SingletonDio.dart';

Future<void> addTask(AddTaskRequest request) async {
  //Lance une request pour addTask
  // 'http://10.0.2.2:8080/api/id/signup'
  await SingletonDio.getDio()
      .post('https://kickmyb-server.herokuapp.com/api/add', data: request);
}
