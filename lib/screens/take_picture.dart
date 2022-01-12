import 'dart:io';

import 'package:blurry/blurry.dart';
import 'package:image/image.dart' as img;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:maizeapp/screens/classifier.dart';
import 'package:maizeapp/screens/classifier_quant.dart';
import 'package:logger/logger.dart';
import 'package:maizeapp/screens/results_page.dart';
import 'package:tflite_flutter_helper/tflite_flutter_helper.dart';

class TakePicture extends StatefulWidget {
  const TakePicture({Key key, this.title}) : super(key: key);

  final String title;
  @override
  _TakePictureState createState() => _TakePictureState();
}

class _TakePictureState extends State<TakePicture> {
  Classifier _classifier;

  var logger = Logger();

  File _image;
  final picker = ImagePicker();

  Image _imageWidget;

  img.Image fox;

  Category category;

  @override
  void initState() {
    super.initState();
    _classifier = ClassifierQuant();
  }

  //get image from gallery
  void _getImage(BuildContext context) async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      _image = File(pickedFile.path);
      _imageWidget = Image.file(_image);

      _predict();
    });
    Navigator.pop(context);
  }

  //get image from phone camera
  void _getImageCamera(BuildContext context) async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);

    setState(() {
      _image = File(pickedFile.path);
      _imageWidget = Image.file(_image);

      _predict();
    });
    Navigator.pop(context);
  }

  //the predict function that takes in the image
  void _predict() async {
    img.Image imageInput = img.decodeImage(_image.readAsBytesSync());
    var pred = _classifier.predict(imageInput);

    setState(() {
      this.category = pred;
    });
  }

  //display the dialog box for user to select image
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
                      _getImage(context);
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
                      _getImageCamera(context);
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
      body: Column(
        children: <Widget>[
          Center(
            child: _image == null
                ? Card(
                    child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                        const ListTile(
                          leading: Icon(Icons.camera_alt_rounded),
                          title: Text(
                            'No image selected ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle:
                              Text('Click on button below to submit an image.'),
                        ),
                        const SizedBox(
                          width: 300,
                          height: 100,
                        )
                      ]))
                : Container(
                    constraints: BoxConstraints(
                        maxHeight: MediaQuery.of(context).size.height / 2),
                    decoration: BoxDecoration(
                      border: Border.all(),
                    ),
                    child: _imageWidget,
                  ),
          ),
          Center(
            child: SizedBox(
              width: 200,
              child: category != null
                  ? ElevatedButton(
                      onPressed: () {
                        _blurry(context);
                      },
                      child: const Text('View Results'),
                    )
                  : Text(''),
            ),
          ),
          SizedBox(
            height: 8,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showChoiceDialog(context);
        },
        tooltip: 'Pick Image',
        child: Icon(Icons.add_a_photo),
      ),
    );
  }

  void _blurry(BuildContext context) {
    Blurry.success(
      title: 'Results',
      description: 'Diagnosis: ${category.label}   \n'
          'Confidence: ${category.score.toStringAsFixed(3)}',
      confirmButtonText: 'Proceed',
      onConfirmButtonPressed: () {
        _checkLabel();
      },
      barrierColor: Colors.white.withOpacity(0.7),
      dismissable: false,
    ).show(context);
  }

  Future<bool> _checkLabel() {
    if (category.label == "1 NitrogenDeficient") {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => Results()));
    } else {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => TakePicture()));
    }
  }
}
