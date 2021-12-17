import 'package:flutter/material.dart';
import 'package:go_green/utils/routes.dart';
import 'pages/login_page.dart';

void main() {
  runApp(GoGreen());
}

class GoGreen extends StatelessWidget{
  const GoGreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "/",
      routes: {
        "/": (context) => LoginPage(),
        MyRoutes.loginRoute : (context) => LoginPage(),
      }
    );
  }

}



