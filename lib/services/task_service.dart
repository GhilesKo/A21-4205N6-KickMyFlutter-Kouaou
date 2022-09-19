import 'package:kickmyflutter/models/DTOs/requests/AddTaskRequest.dart';
import 'package:kickmyflutter/models/DTOs/responses/HomeItemResponse.dart';
import 'package:kickmyflutter/models/SingletonDio.dart';


Future<List<HomeItemResponse>> getTasks() async {
  //Lance une request pour getTask
  // 'http://10.0.2.2:8080/api/home'
  final response = await SingletonDio.getDio()
      .get('https://kickmyb-server.herokuapp.com/api/home');
  List<HomeItemResponse> tasks = [];
  for (var task in response.data) {
    HomeItemResponse item = HomeItemResponse.fromJson(task);
    tasks.add(item);
  }

  return tasks;
}


Future<void> addTask(AddTaskRequest request) async {
  //Lance une request pour addTask
  // 'http://10.0.2.2:8080/api/id/signup'
  await SingletonDio.getDio()
      .post('https://kickmyb-server.herokuapp.com/api/add', data: request);
}

