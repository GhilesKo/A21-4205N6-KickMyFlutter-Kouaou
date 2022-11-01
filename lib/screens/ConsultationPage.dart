import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kickmyflutter/main.dart';
import 'package:kickmyflutter/models/DTOs/responses/HomeItemResponse.dart';
import 'package:kickmyflutter/models/SingletonDio.dart';
import 'package:kickmyflutter/screens/HomePage.dart';
import 'package:kickmyflutter/services/task_service.dart';

import '../i18n/intl_localization.dart';
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
  Image? NetworkImage;
  bool isLoading = true;
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

  Future<Image?> getNetworkImage()  async {

    isLoading = true;
    try {

      NetworkImage =  await Image.network("https://kickmyb-server.herokuapp.com/file/${_task!.photoId}");
      isLoading = false;
      setState(() {

      });
    } on DioError catch (e) {
      print(e);
      isLoading = false;
      setState(() {

      });
    }

    return NetworkImage;

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


  try {
    await SingletonDio.getDio().post(
        'https://kickmyb-server.herokuapp.com/file',data: formData);
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()));

  } on DioError catch (e) {
    print(e);
  }

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
                  "${_task!.percentageDone}%" +Locs.of(context).trans('completed'),
                  style: const TextStyle(fontSize: 25),
                ),
                Text(
                  "${_task!.percentageTimeSpent < 0 ? 0 : _task!.percentageTimeSpent}%"+Locs.of(context).trans('tempss'),
                  style: const TextStyle(fontSize: 25),
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  onChanged: (value) => pourcentage = int.parse(value),
                ),
                ElevatedButton(
                    onPressed: _updateTask, child:  Text(Locs.of(context).trans('update'))),
                ElevatedButton(
                    onPressed: getImage, child:  Text(Locs.of(context).trans('choose')))


              ],
            ),
            Expanded(
              child: Column(children: [
                Container(margin: EdgeInsets.only(top: 40),alignment: Alignment.center,child: (_task!.photoId==0 && imagePath=="")?Text(Locs.of(context).trans('select')):
                (imagePath != "" )?  SizedBox(height: 300,width: 300,child: Image.file(File(imagePath))):
SizedBox(height: 300,width: 300,child:
CachedNetworkImage(
  imageUrl: "https://kickmyb-server.herokuapp.com/file/${_task!.photoId}",
  placeholder: (context, url) => Center(child: CircularProgressIndicator()),
  errorWidget: (context, url, error) => Icon(Icons.add_a_photo),
)
)
               )
                ,
                Expanded(child: Align(alignment: Alignment.bottomCenter,child: ElevatedButton(onPressed: sendImageTask, child: Text(Locs.of(context).trans('save')))))
              ],),
            )
          ],
        ));
  }
}
