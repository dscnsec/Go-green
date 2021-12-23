import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_green/pages/welcome_page.dart';
import 'package:go_green/provider/google_sign_in.dart';
import 'package:provider/provider.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {

    //*******************************************//
   //           temporay about page             //
  //*******************************************//


  Widget aboutInfo(BuildContext context)
  {
  final googleUser = FirebaseAuth.instance.currentUser!;
    return Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundImage: Image.network(googleUser.photoURL ?? '').image,
                    radius: 80,
                    backgroundColor: Colors.lightGreen,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    googleUser.displayName ?? '',
                    style: const TextStyle(
                      fontSize: 25,
                    )),
                  Text(
                    googleUser.email ?? '',
                    style: const TextStyle(
                      fontSize: 15,
                    ),
                    ),
                  const SizedBox(
                      height: 20,
                  ),
                  ActionChip(
                    avatar: const Icon(Icons.logout),
                    label: const Text('Logout'),
                    onPressed: (){
                      final provider = Provider.of<GoogleSignInProvider>(context, listen: false);
                      provider.logout();
                  }) 
                ]
              ),
            );
  }

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
              return aboutInfo(context);
            }
            else if(snapshot.hasError){
              return const Center(child: Text('Something Went Wrong'),);
            }
            return WelcomePage();
          }
        )
    );
  }
}