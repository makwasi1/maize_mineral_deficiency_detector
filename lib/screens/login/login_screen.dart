// import 'package:flutter/material.dart';
// import 'package:maizeapp/repositories/user_repository.dart';
// import 'package:maizeapp/widgets/curved_widget.dart';
//
// import 'login_form.dart';
//
// class LoginScreen extends StatelessWidget {
//   LoginScreen(UserRepository userRepository);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       extendBodyBehindAppBar: true,
//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: Colors.transparent,
//       ),
//       body: Container(
//         height: double.infinity,
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//             colors: [Colors.lightGreen[100], Colors.lightGreen.shade100]
//           )
//         ),
//         child: SingleChildScrollView(
//           child: Stack(
//             children: <Widget>[
//               CurvedWidget(
//                 child: CurvedWidget(
//                   child: Container(
//                     padding: const EdgeInsets.only(top: 100, left: 50),
//                     width: double.infinity,
//                     height: 400,
//                     decoration: BoxDecoration(
//                         gradient: LinearGradient(
//                             begin: Alignment.topCenter,
//                             end: Alignment.bottomCenter,
//                             colors: [Colors.white, Colors.white.withOpacity(0.4)]
//                         )
//                     ),
//                     child: Text('Login', style: TextStyle(
//                       fontSize: 40,
//                       color: Color(0xff6a515e)
//                     )),
//                   ),
//                 ),
//               ),
//               Container(
//                 margin: const EdgeInsets.only(top: 300),
//                 child: LoginForm(),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maizeapp/bloc/login_bloc/login_bloc.dart';
import 'package:maizeapp/repositories/user_repository.dart';
import 'package:maizeapp/widgets/curved_widget.dart';

import 'login_form.dart';

class LoginScreen extends StatelessWidget {
  final UserRepository _userRepository;

  const LoginScreen({Key key, UserRepository userRepository})
      : _userRepository = userRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: BlocProvider<LoginBloc>(
        create: (context) => LoginBloc(userRepository: _userRepository),
        child: Container(
          height: double.infinity,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.green, Colors.lightGreenAccent],
              )),
          child: SingleChildScrollView(
            child: Stack(
              children: <Widget>[
                CurvedWidget(
                  child: Container(
                    padding: const EdgeInsets.only(top: 100, left: 50),
                    width: double.infinity,
                    height: 300,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.white, Colors.white.withOpacity(0.4)],
                      ),
                    ),
                    child: Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 40,
                        color: Color(0xff6a515e),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 230),
                  child: LoginForm(userRepository: _userRepository,),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}