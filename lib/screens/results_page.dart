import 'package:flutter/material.dart';
class Results extends StatefulWidget {


  @override
  _ResultsState createState() => _ResultsState();
}

class _ResultsState extends State<Results> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Results"),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
    );
  }
}