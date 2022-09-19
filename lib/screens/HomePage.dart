import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kickmyflutter/models/DTOs/responses/HomeItemResponse.dart';
import 'package:kickmyflutter/models/SingletonUser.dart';
import 'package:kickmyflutter/screens/CreationPage.dart';
import 'package:kickmyflutter/screens/ConsultationPage.dart';
import 'package:kickmyflutter/services/auth_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final DateFormat formatter = DateFormat('yMMMMEEEEd');
  List<HomeItemResponse> tasks = [];
  bool isLoading = false;

  Future<void> _getTasks() async {
    setState(() => isLoading = true);
    try {
      tasks = await getTask();
    } on DioError catch (e) {
      final snackBar = SnackBar(content: Text(e.response?.data));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

    setState(() => isLoading = false);
  }

  @override
  void initState() {
    super.initState();
    _getTasks();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: Text("Hello ${SingletonUser.instance.username}"),
      ),
      body: isLoading
          ? const Center(
              child: SizedBox(
                width: 75,
                height: 75,
                child: CircularProgressIndicator(
                  strokeWidth: 5,
                ),
              ),
            )
          : tasks.isNotEmpty
              ? ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ConsultationPage()),
                        );
                      },
                      title: Wrap(
                        alignment: WrapAlignment.spaceBetween,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        direction: Axis.horizontal,
                        children: [
                          Text(tasks[index].name),
                          Text(formatter.format(tasks[index].deadline)),
                        ],
                      ),
                      leading: CircularProgressIndicator(
                        strokeWidth: 5,
                        value: tasks[index].percentageDone.toDouble() / 10,
                        backgroundColor: Colors.black12,
                      ),
                      subtitle: Row(
                        children: const [
                          Text("Temps écoulé  "),
                          //TODO: Ajuster la progress bar en fonction des jours restants
                          Expanded(child: LinearProgressIndicator(value: 0.8))
                        ],
                      ),
                    );
                  },
                )
              : const Center(child: Text('Aucune tâches existantes')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddTaskPage()),
          ).then((value) async {
            await _getTasks();
            setState(() {});
          });
        },
        child: const Icon(Icons.add),
      ));
}
