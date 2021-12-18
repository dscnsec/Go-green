import 'package:flutter/material.dart';
import 'package:go_green/utils/routes.dart';
import 'pages/welcome_page.dart';

void main() {
  runApp(GoGreen());
}

class GoGreen extends StatelessWidget{
  const GoGreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.grey.shade200,
        fontFamily: 'Roboto',
      ),
      initialRoute: "/",
      routes: {
        "/": (context) => WelcomePage(),
        MyRoutes.welcomeRoute : (context) => WelcomePage(),
      }
    );
  }

}



