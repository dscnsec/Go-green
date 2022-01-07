import 'package:flutter/material.dart';
import 'package:go_green/provider/google_sign_in.dart';
import 'package:go_green/utils/routes.dart';
import 'package:provider/provider.dart';

class WelcomePage extends StatefulWidget{
  const WelcomePage({Key? key}) : super(key: key);

  @override
  _WelcomePage createState() => _WelcomePage();
}

class _WelcomePage extends State<WelcomePage>{
  
  Widget _loginBanner(){

          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     Container(
                      //top: 25,
                      //left: 50,
                      child: Image.asset(
                      'assets/images/login_image.png',
                      fit: BoxFit.contain,
                      scale: 4,
                      ),
                      transform: Matrix4.translationValues(15, 0, 0)                 
                    ),
                    Container(
                      //top: 32,
                      //left: 170,
                      child: Text('GO\nGREEN',
                        style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.w700,
                          color: Colors.grey[700]
                        )),
                        transform: Matrix4.translationValues(0, 10, 0)                 
                        ),
                  ],
          );
  }


  Widget _loginWithGmail(BuildContext context){


    return Column(
      children:[
          Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
              ElevatedButton(
                onPressed: () {
                  final provider = Provider.of<GoogleSignInProvider>(context, listen: false);
                  provider.googleLogin();
                }, 

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    Image.asset(
                      'assets/icons/g_icon.png',
                       width: 18,
                       height: 18,
                      ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Text('Login with Google'),
                      ],
                    ),
                  
                  style: ElevatedButton.styleFrom(
                    textStyle: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                  primary: Colors.lightBlue.shade300,
                  onPrimary: Colors.white,
                  shadowColor: Colors.white,
                  shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),  
                  minimumSize: const Size(80, 40),
                  maximumSize: const Size(190, 80),
               ),
              ), 
      ])]);
  }

  @override
  Widget build(BuildContext context){

    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
         height: MediaQuery.of(context).size.height,
         width: MediaQuery.of(context).size.width, 
         child: SafeArea(
           child: Column(
             crossAxisAlignment: CrossAxisAlignment.center,
             mainAxisAlignment: MainAxisAlignment.start,
             children: [
               SizedBox(
                 height: MediaQuery.of(context).size.height*0.16,
               ),
              Flexible(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: _loginBanner(),
                  ), 
                ),
              const SizedBox(
                height: 20,
              ),
               Text(
                'A task based game!',
                style: TextStyle(
                  color: Colors.grey.shade700,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height*0.1,
              ),
              Flexible(child: _loginWithGmail(context)) 
             ],
           ),
        ),
        ),
      ),
    );
  }
}

