import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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
   String imagePath ="";
  String imageNetworkPath ="";
  XFile? pickedImage;

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

  
  void initState() {
    // TODO: implement initState
    _getTaskDetails();
    super.initState();
  }

  Future<void> getImage() async {

    ImagePicker picker = ImagePicker();
     pickedImage = await picker.pickImage(source: ImageSource.gallery);

    try {
      imagePath = pickedImage!.path;
    } on DioError catch (e) {
      print(e);
    }
    setState(() {

    });


  }

  void sendImageTask() async {

  FormData formData = FormData.fromMap({
    "file" : await MultipartFile.fromFile(imagePath, filename: pickedImage!.name),
    "taskID" : widget.id.toString()
  });

  Dio dio = Dio();
  var response = await dio.post('https://kickmyb-server.herokuapp.com/file',data: formData);
  print(response.data);
  print(widget.id);
  }

    Future<void> getTaskImage () async {


      var response = await SingletonDio.getDio().get('https://kickmyb-server.herokuapp.com/api/detail/photo/${widget.id}');
      print(response.data.photoId);

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
        body: Column(
          children: [
            Column(

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
                    onPressed: _updateTask, child: const Text('Mettre à jour')),
                ElevatedButton(
                    onPressed: getImage, child: const Text('Choisir une image'))


              ],
            ),
            Expanded(
              child: Column(children: [
                Container(margin: EdgeInsets.only(top: 40),alignment: Alignment.center,child: (_task!.photoId==0 && imagePath=="")?Text("Selectionnez une image"):
                (imagePath != "" )?  SizedBox(height: 300,width: 300,child: Image.file(File(imagePath))):
                SizedBox(height: 300,width: 300,child: Image.network("https://kickmyb-server.herokuapp.com/file/${_task!.photoId}")))
                ,
                Expanded(child: Align(alignment: Alignment.bottomCenter,child: ElevatedButton(onPressed: sendImageTask, child: Text("Sauvegarder"))))
              ],),
            )
          ],
        ));
  }
}
