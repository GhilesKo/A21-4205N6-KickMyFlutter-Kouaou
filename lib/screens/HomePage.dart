import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kickmyflutter/models/DTOs/responses/HomeItemResponse.dart';
import 'package:kickmyflutter/models/SingletonUser.dart';
import 'package:kickmyflutter/screens/CreationPage.dart';
import 'package:kickmyflutter/screens/ConsultationPage.dart';
import 'package:kickmyflutter/services/task_service.dart';
import 'package:kickmyflutter/widgets/CustomDrawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final DateFormat formatter = DateFormat('yMMMMEEEEd');
  List<HomeItemResponse> tasks = [];
  bool isLoading = false;
  Image? networkImage;
  Future<void> _getTasks() async {
    setState(() => isLoading = true);
    try {
      tasks = await getTasks();
    } on DioError catch (e) {
      final snackBar = SnackBar(content: Text(e.response?.data));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }


    setState(() => isLoading = false


    );

  }


  @override
  void initState() {
    super.initState();
    _getTasks();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      drawer: const CustomDrawer(),
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
                              builder: (context) =>
                                  ConsultationPage(id: tasks[index].id)),
                        ).then((value) async {
                          await _getTasks();

                        });
                      },
                      title: Wrap(
                        alignment: WrapAlignment.spaceBetween,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        direction: Axis.horizontal,
                        children: [
                          Text(tasks[index].name),
                          Text(formatter.format(tasks[index].deadline)),
                       CachedNetworkImage(
                            imageUrl: "https://kickmyb-server.herokuapp.com/file/${tasks[index].photoId}?width=30",
                            placeholder: (context, url) => CircularProgressIndicator(),
                            errorWidget: (context, url, error) => Icon(Icons.add_a_photo)

                          )
                          ],
                      ),

                      subtitle: Row(
                        children:  [
                          const Text("Temps écoulé  "),
                          //TODO: Ajuster la progress bar en fonction des jours restants
                          Expanded(child: LinearProgressIndicator(
                              value: (tasks[index].percentageTimeSpent.toDouble() / 100 < 0)
                              ? 1
                              : (tasks[index].percentageTimeSpent.toDouble() / 100),backgroundColor: Colors.black26, )),

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
