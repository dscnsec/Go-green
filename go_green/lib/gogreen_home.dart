import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_green/provider/database.dart';
import 'package:go_green/pages/welcome_page.dart';
import 'nav_bar.dart';

class GoGreenHome extends StatefulWidget {
  const GoGreenHome({Key? key}) : super(key: key);

  @override
  _GoGreenHomeState createState() => _GoGreenHomeState();
}

class _GoGreenHomeState extends State<GoGreenHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
              if( snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              else if (snapshot.hasData){
                final user = snapshot.data as User;
                DataBase.userUid=user.uid ;
      
                debugPrint('snapshot.hasData = $snapshot.hasData');
                return const NavBar();
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
       );  }
}

