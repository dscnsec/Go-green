import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:go_green/firebase_options.dart';
import 'package:go_green/gogreen_home.dart';
import 'package:go_green/pages/about_page.dart';
import 'package:go_green/pages/task_page.dart';
import 'package:go_green/provider/google_sign_in.dart';
import 'package:go_green/utils/routes.dart';
import 'package:provider/provider.dart';
import 'pages/welcome_page.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const GoGreen());
}

class GoGreen extends StatelessWidget{
  const GoGreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => GoogleSignInProvider(),
      child: MaterialApp(
        theme: ThemeData(
          brightness: Brightness.light,
          scaffoldBackgroundColor: Colors.grey.shade200,
          fontFamily: 'Roboto',
          checkboxTheme: CheckboxThemeData(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5)
              )
          )
        ),
        initialRoute: "/",
        routes: {
          "/": (context) => const GoGreenHome(),
          MyRoutes.welcomeRoute : (context) => const WelcomePage(),
          MyRoutes.taskPage : (context) => TaskPage(),
          MyRoutes.aboutRoute : (context) => const AboutPage(),
        }
      ),
    );
  }

}



