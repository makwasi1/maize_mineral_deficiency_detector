import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maizeapp/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:maizeapp/bloc/authentication_bloc/authentication_event.dart';
import 'package:maizeapp/screens/take_picture.dart';
import 'package:maizeapp/widgets/navigation_drawer_widget.dart';

class HomeScreen extends StatelessWidget {
  final User user;

  const HomeScreen({Key key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[500],
        title: Text('MMD',textAlign: TextAlign.center,),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              BlocProvider.of<AuthenticationBloc>(context)
                  .add(AuthenticationLoggedOut());
            },
          )
        ],
      ),
      drawer: NavigationDrawerWidget(),
      body: ListView(
        children: <Widget>[
          Image.asset(
              'images/image1.jpg',
              width: 600,
              height: 240,
              fit: BoxFit.cover,
              ),
          titleSection,
          textSection,
          Center(
            child: ElevatedButton(onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => TakePicture()));
            },

                child: Text("Get Started")
            ),
          )
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
                'Welcome to MMD',
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
        'Lake Oeschinen lies at the foot of the Blüemlisalp in the Bernese '
        'Alps. Situated 1,578 meters above sea level, it is one of the '
        'larger Alpine Lakes. A gondola ride from Kandersteg, followed by a '
        'half-hour walk through pastures and pine forest, leads you to the '
        'lake, which warms to 20 degrees Celsius in the summer. Activities '
        'enjoyed here include rowing, and riding the summer toboggan run.',
    softWrap: true,
    style: TextStyle(
      fontSize: 17,
    ),
  ),
);