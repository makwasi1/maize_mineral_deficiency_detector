import 'package:flutter/material.dart';
class OtherPage extends StatefulWidget {
  @override
  _OtherPageState createState() => _OtherPageState();
}

class _OtherPageState extends State<OtherPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Take Picture"),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
    );
  }
}
