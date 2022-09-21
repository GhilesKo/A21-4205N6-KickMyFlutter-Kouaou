import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:kickmyflutter/models/DTOs/responses/HomeItemResponse.dart';
import 'package:kickmyflutter/models/SingletonDio.dart';
import 'package:kickmyflutter/services/task_service.dart';

import '../widgets/CustomDrawer.dart';

class ConsultationPage extends StatefulWidget {
  const ConsultationPage({Key? key, required this.id}) : super(key: key);

  final int id;

  @override
  State<ConsultationPage> createState() => _ConsultationPageState();
}

class _ConsultationPageState extends State<ConsultationPage> {
  HomeItemResponse? _task;

  int? pourcentage;

  _getTaskDetails() async {
    _task = await getTaskDetails(widget.id);
    setState(() {});
  }

  Future<void> _updateTask() async {
    try {
      await SingletonDio.getDio().get(
          'https://kickmyb-server.herokuapp.com/api/progress/${widget.id}/$pourcentage');
      Navigator.pop(context);
    } on DioError catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    _getTaskDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_task == null) {
      return Scaffold(
          drawer: const CustomDrawer(),
        appBar: AppBar(
          title: const Text("Consultation"),
        ),
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    return Scaffold(
        drawer: const CustomDrawer(),
        appBar: AppBar(
          title: const Text("Consultation"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _task!.name,
                style: const TextStyle(fontSize: 35),
              ),
              Text(
                _task!.deadline.toString(),
                style: const TextStyle(fontSize: 25),
              ),
              Text(
                "${_task!.percentageDone}% complété",
                style: const TextStyle(fontSize: 25),
              ),
              Text(
                "${_task!.percentageTimeSpent < 0 ? 0 : _task!.percentageTimeSpent}% temps écoulé",
                style: const TextStyle(fontSize: 25),
              ),
              TextField(
                keyboardType: TextInputType.number,
                onChanged: (value) => pourcentage = int.parse(value),
              ),
              ElevatedButton(
                  onPressed: _updateTask, child: const Text('Mettre à jour'))
            ],
          ),
        ));
  }
}
