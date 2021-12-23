import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_green/pages/about_page.dart';
import 'package:go_green/pages/task_page.dart';
import 'package:go_green/pages/welcome_page.dart';

class GoGreenHome extends StatefulWidget {
  const GoGreenHome({Key? key}) : super(key: key);

  @override
  _GoGreenHomeState createState() => _GoGreenHomeState();
}

class _GoGreenHomeState extends State<GoGreenHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
            if( snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            else if (snapshot.hasData){
              debugPrint('snapshot.hasData = $snapshot.hasData');
              return AboutPage();
            }
            else if(snapshot.hasError){
              return const Center(
                child: Text(
                  'Something Went Wrong', 
                  style: TextStyle(
                    color: Colors.red,
                  )
                  ),
                );
            }
            return const WelcomePage();
          },
     ),
    );
  }
}