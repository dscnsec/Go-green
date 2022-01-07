import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_green/provider/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/link.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {

  final googleUser = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    final textStyle1= TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Colors.grey.shade800
    );

    final textStyle2 = TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: Colors.grey.shade800
    );
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                     SizedBox(
                      height: MediaQuery.of(context).size.height*0.1,
                    ),
                    ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      child: Image.network(
                        googleUser.photoURL ?? '', 
                        width: 130,
                        height: 130,
                        fit: BoxFit.fill,
                        //color: Colors.lightGreen,
                        ),
                      //radius: 70,
                      //backgroundColor: Colors.lightGreen,
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Flexible(
                      child: Column(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width*0.85,
                            child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Account Details: ',
                                style: textStyle1),
                                const SizedBox( height: 20,),
                                Text(
                                  "Name: ${googleUser.displayName ?? ''}",
                                  style: textStyle2,
                                ),
                                Text(
                                "Email: ${googleUser.email ?? ''}",
                                style: textStyle2,
                                ),
                              ],
                            ),
                          ),
                    
                          const SizedBox(
                              height: 30,
                          ),
                          ActionChip(
                            avatar: const Icon(Icons.login_rounded),
                            label: const Text('Logout', style: TextStyle(fontWeight: FontWeight.bold),),
                            labelPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            onPressed: (){
                              final provider = Provider.of<GoogleSignInProvider>(context, listen: false);
                              provider.logout();
                          }), 
                          const SizedBox(
                            height: 30,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width*0.85,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('About:',
                                style: textStyle1,),
                                const SizedBox( height: 20,) ,
                                Text(
                                  'GoGreen: A task based game to make the world a better place by completing one task at a time.',
                                  style: textStyle2),
                                  const SizedBox( height: 20),
                                Text('Links:',
                                style: textStyle1) ,
                                const SizedBox( height: 20),
                                Row(
                                  children: [
                                    Text('Source code: ', 
                                    style: textStyle2),
                                    Link(
                                      uri: Uri.parse("https://github.com/SP-XD/Go-green"), 
                                      builder: (context, followLink) => GestureDetector(
                                        onTap: followLink,
                                        child: Text( 'Github',
                                               style: TextStyle(
                                                 fontSize: 14,
                                                 fontWeight: FontWeight.w600,
                                                 color: Colors.lightGreen.shade600
                                               ))
                                      ),
                                      ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox( height: 45),
                          const Text('Made with 💚 in India')
                        ],
                      ),
                    ),
                  ]
                ),
              ),
    );
  }

}