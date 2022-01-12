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
      body: ListView(
        children: <Widget>[
          titleSection,
          textSection,
        ],
      ),
    );
  }
}

Widget titleSection = Container(
  padding: const EdgeInsets.all(32),
  child: Row(
    children: [
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.only(bottom: 8),
              child: const Text(
                'Way Forward',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
      /*3*/
    ],
  ),
);
Widget titleSection2 = Container(
  padding: const EdgeInsets.all(32),
  child: Row(
    children: [
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.only(bottom: 8),
              child: const Text(
                'Identified Deficiency:'
                'Nitrogen Deficiency',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
      /*3*/
    ],
  ),
);
Widget titleSection3 = Container(
  padding: const EdgeInsets.all(32),
  child: Row(
    children: [
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.only(bottom: 8),
              child: const Text(
                'Date: 25th December            Time: 10:10PM',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
      /*3*/
    ],
  ),
);

Widget textSection = const Padding(
  padding: EdgeInsets.all(10),
  child: Text(
    'Apply 50 Grams of the NPK fertilizer into the soil'
    'around the plant and water it everyday'
    'Make sure that you do not use more than 3 Liters of '
    'water in one go when watering the plant ',
    textAlign: TextAlign.center,
    softWrap: true,
    style: TextStyle(
      fontSize: 17,
    ),
  ),
);
