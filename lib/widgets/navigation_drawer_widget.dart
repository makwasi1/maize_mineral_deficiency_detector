import 'package:flutter/material.dart';
import 'package:maizeapp/screens/other_page.dart';
import 'package:maizeapp/screens/results_page.dart';
import 'package:maizeapp/screens/take_picture.dart';

class NavigationDrawerWidget extends StatelessWidget {
  final padding = EdgeInsets.symmetric(horizontal: 20);
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        color: Colors.green[400],
        child: ListView(
          padding: padding,
          children: <Widget>[
            const SizedBox(height: 40),
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.green[400],
              ),
              child: Text(
                'MMD App',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            buildMenuItem(
                text: "Take Picture",
                icon: Icons.camera_enhance_sharp,
                onClicked:() => selectedItem(context, 0),
            ),
            const SizedBox(height: 40),
            buildMenuItem(
                text: "Results",
                icon: Icons.article_outlined,
              onClicked:() => selectedItem(context, 1),),
            const SizedBox(height: 40),
            buildMenuItem(
                text: "Settings",
                icon: Icons.settings,
              onClicked:() => selectedItem(context, 2),),
          ],
        ),
      ),
    );
  }

  selectedItem(BuildContext context, int i) {
    Navigator.of(context).pop();
    switch (i) {
      case 0:
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => TakePicture()));
        break;
      case 1:
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => Results()));
        break;
      case 2:
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => OtherPage()));
        break;
    }
  }
}

Widget buildMenuItem({String text,
  IconData icon,
  VoidCallback onClicked}) {
  final color = Colors.white;

  return ListTile(
      leading: Icon(icon, color: color),
      title: Text(
        text,
        style: TextStyle(color: color),
      ), onTap: onClicked,);
}
