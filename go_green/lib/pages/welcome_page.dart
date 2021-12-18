import 'package:flutter/material.dart';

class WelcomePage extends StatefulWidget{
  const WelcomePage({Key? key}) : super(key: key);

  @override
  _WelcomePage createState() => _WelcomePage();
}

class _WelcomePage extends State<WelcomePage>{

  Widget _loginBanner(){

          return Row(
                  children: [
                     Container(
                      //top: 25,
                      //left: 50,
                      child: Image.asset(
                      'assets/images/login_image.png',
                      fit: BoxFit.contain,
                      scale: 4,
                      ),
                      transform: Matrix4.translationValues(65, 0, 0)                 
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
                        transform: Matrix4.translationValues(35, -65, 0)                 
                        ),
                  ],
          );
  }

  Widget _loginWithEmail(BuildContext context){

    final ButtonStyle buttonStyle = ElevatedButton.styleFrom(
    textStyle: const TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.bold,
    ),
    primary : Colors.orange.shade400,
    onPrimary: Colors.white,
    shadowColor: Colors.white,
    shape: RoundedRectangleBorder(
       borderRadius: BorderRadius.circular(6),
     ),  
     minimumSize: const Size(100, 40) 
    );

    return Column(
      children:[
          Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: (){}, 
                    child: const Text('Login'),
                    style: buttonStyle,
                 ),
                 const SizedBox(
                   width: 20,
                 ),
                 ElevatedButton(
                   onPressed: (){}, 
                   child: const Text('Register'),
                   style: buttonStyle,
                   )

              ],),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'OR',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                )
              ), 
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: (){}, 
                 
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  Image.asset(
                    'assets/icons/g_icon.png',
                     width: 16,
                     height: 16,
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
                  borderRadius: BorderRadius.circular(6),
                ),  
                  maximumSize: const Size(190, 40),
               ),
              ), 
      ]);
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
               const SizedBox(
                 height: 70,
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
              const SizedBox(
                height: 70,
              ),
              Flexible(child: _loginWithEmail(context)) 
             ],
           ),
        ),
        ),
      ),
    );
  }
}

