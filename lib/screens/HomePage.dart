import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:kickmyflutter/models/DTOs/HomeItemResponse.dart';
import 'package:kickmyflutter/models/SingletonUser.dart';
import 'package:kickmyflutter/screens/AddTaskPage.dart';
import 'package:kickmyflutter/screens/ConsultationPage.dart';
import 'package:kickmyflutter/services/auth_service.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<HomeItemResponse> tasks = [];

  bool isLoading = false;

  Future<void> _getTasks() async
  {

    setState(()=> isLoading = true);
    try {
      tasks = await getTask();

      setState(() {});
    } on DioError catch (e) {
      print(e);
    } catch (e) {
      print(e);
    }

    setState(()=> isLoading = false);

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
      body: isLoading == true ? Center(
        child: SizedBox( width: 75,height: 75,
          child: CircularProgressIndicator(
            strokeWidth: 5,

          ),
        ),

      ) : ListView.builder(
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
                Text(tasks[index].deadline.toString()),
              ],
            ),
            leading: CircularProgressIndicator(
              value: tasks[index].percentageDone.toDouble() / 10,
              backgroundColor: Colors.black12,
            ),
            subtitle: Row(
              children: [
                const Text("Temps écoulé :  "),
                //TODO: Ajuster la progress bar en fonction des jours restants
                const Expanded(child: const LinearProgressIndicator(value: 0.8))
              ],
            ),
          );
        },
      ) ,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddTaskPage()),
          );
        },
        child: const Icon(Icons.add),
      ));
}
