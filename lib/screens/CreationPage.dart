import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:kickmyflutter/models/DTOs/requests/AddTaskRequest.dart';
import 'package:kickmyflutter/services/task_service.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({Key? key}) : super(key: key);

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  //Formatteur pour afficher la date de la bonne facon
  final DateFormat formatter = DateFormat('yMMMMEEEEd');
  DateTime? _deadline;
  String? _taskName;
  bool submitted = false;

  //Valid que les champs ne sont pas null, pour activer la button addTask
  bool _validation() {
    if (_deadline == null) return false;
    if (_taskName == null) return false;
    return true;
  }

  //Envoie une requete au serveur pour ajouter une task
  Future<void> _addTask() async {
    setState(() => submitted = true);
    try {
      AddTaskRequest addTaskRequest = AddTaskRequest(_taskName!, _deadline!);
      await addTask(addTaskRequest);
      if (mounted) {
        Navigator.pop(context);
      }
    } on DioError catch (e) {
      final snackBar = SnackBar(content: Text(e.response?.data));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

    setState(() => submitted = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Creation"),
      ),
      body: Column(
        children: [
          TextField(
            onChanged: (value) => setState(() => _taskName = value),
            decoration: const InputDecoration(hintText: 'Nom de la tâche'),
          ),
          Text(_deadline != null ? formatter.format(_deadline!) : ''),
          TextButton(
              onPressed: () {
                DatePicker.showDatePicker(context,
                    showTitleActions: true,
                    minTime: DateTime(2020),
                    maxTime: DateTime(2030),
                    onChanged: (date) => setState(() => _deadline = date),
                    onConfirm: (date) => setState(() => _deadline = date),
                    currentTime: DateTime.now(),
                    locale: LocaleType.en);
              },
              child: Text(
                _deadline == null
                    ? "Choisir une date d'échéance"
                    : "Changer la date d'échéance",
                style: const TextStyle(color: Colors.blue),
              )),
          ElevatedButton(
              //!submitted ? _signIn : null,
              onPressed: !submitted && _validation() ? _addTask : null,
              child: const Text(
                'Créer une tâche',
                style: TextStyle(color: Colors.white),
              ))
        ],
      ),
    );
  }
}
