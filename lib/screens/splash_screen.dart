import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/splash_screen_bloc.dart';
import 'home_page.dart';
import 'splash_screen_widget.dart';

// This the widget where the BLoC states and events are handled.
class SplashScreen extends StatelessWidget {
  SplashScreenState get initialState => Loading();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
    );
  }

  BlocProvider<SplashScreenBloc> _buildBody(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashScreenBloc(initialState),
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.orange,
        child: Center(
          // Here I have used BlocBuilder, but instead you can also use BlocListner as well.
          child: BlocBuilder<SplashScreenBloc, SplashScreenState>(
            builder: (context, state) {
              if ((state is Initial) || (state is Loading)) {
                return SplashScreenWidget();
              } else if (state is Loaded) {
                return Home();
              }
              return Utils().errorText(message: 'Error, failed to change state.');
            },
          ),
        ),
      ),
    );
  }
}

class Utils {
  errorText({String message}) {
    return Container(
        child: Align(
          alignment: Alignment.center,
          child: Container(
            margin: EdgeInsets.all(30.0),
            child: Text(message, style: TextStyle(
              fontFamily: 'DMSans',
              fontWeight: FontWeight.normal,
              fontSize:  16.0,
              color: Colors.blue,
              letterSpacing: 0.3,
            )
            ),
          ),
        ));
  }
}

