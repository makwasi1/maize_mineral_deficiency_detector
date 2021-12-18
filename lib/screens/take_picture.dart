import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';

class TakePicture extends StatefulWidget {
  @override
  _TakePictureState createState() => _TakePictureState();
}

class _TakePictureState extends State<TakePicture> {
  List _output;
  var _image;
  bool _loading;
  String _name = "";
  String _confidence = "";
  PickedFile imageFile = null;

  @override
  void initState() {
    super.initState();
    _loading = true;

    loadModal().then((value) {
      setState(() {
        _loading = false;
      });
    });
  }

  Future<void> _showChoiceDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              "Choose option",
              style: TextStyle(color: Colors.blue),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  Divider(
                    height: 1,
                    color: Colors.blue,
                  ),
                  ListTile(
                    onTap: () {
                      _openGallery(context);
                    },
                    title: Text("Gallery"),
                    leading: Icon(
                      Icons.account_box,
                      color: Colors.blue,
                    ),
                  ),
                  Divider(
                    height: 1,
                    color: Colors.blue,
                  ),
                  ListTile(
                    onTap: () {
                      _openCamera(context);
                    },
                    title: Text("Camera"),
                    leading: Icon(
                      Icons.camera,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Take Picture"),
          centerTitle: true,
          backgroundColor: Colors.green,
        ),
        body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                SizedBox(height: 30,),
                Card(
                    child: _image == null
                        ? Text('No image selected.')
                        : Image.file(_image)),
                Container(
                  child:
                    Text("Name: $_name \nConfidence: $_confidence"),
                ),
                MaterialButton(
                  textColor: Colors.white,
                  color: Colors.pink,
                  onPressed: () {
                    _showChoiceDialog(context);
                  },
                  child: Text("Select Image"),
                ),
              ],
            ),

        ));
  }

  void _openGallery(BuildContext context) async {
    XFile image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (image == null) return null;
    setState(() {
      _loading = true;
      _image = File(image.path);
    });
    classifyImage(image);
    Navigator.pop(context);
  }

  void _openCamera(BuildContext context) async {
    XFile image = await ImagePicker().pickImage(
      source: ImageSource.camera,
    );
    if (image == null) return null;
    setState(() {
      _loading = true;
      _image = File(image.path);
    });
    classifyImage(image);
    Navigator.pop(context);
  }

  loadModal() async {
    await Tflite.loadModel(
      model: "assets/model_unquant.tflite",
      labels: "assets/labels.txt",
    );
    print("model has been loaded");
  }

  void classifyImage(XFile image) async {
    var output = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 2,
      threshold: 0.5,
      imageMean: 127.5,
      imageStd: 127.5,
    );
    print("We are here========================");
    print(output);
    setState(() {
      _loading = false;
      _output = output;

      String str = _output[0]["label"];
      _name = str.substring(2);
      _confidence = _output != null ? (_output[0]['confidence']*100.0).toString().substring(0, 2)+"%":"";
    });
    print(_output);
  }
}
