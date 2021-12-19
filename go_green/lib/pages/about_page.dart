import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_green/utils/routes.dart';
import 'package:go_green/login_controller.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {

    //*******************************************//
   //           temporay about page             //
  //*******************************************//

  final controller = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundImage: Image.network(controller.googleAccount.value?.photoUrl ?? '').image,
                radius: 80,
                backgroundColor: Colors.lightGreen,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                controller.googleAccount.value?.displayName ?? '',
                style: Get.textTheme.headline4),
              Text(
                controller.googleAccount.value?.email ?? '',
                style: Get.textTheme.bodyText1,
                ),
              const SizedBox(
                  height: 20,
              ),
              ActionChip(
                avatar: const Icon(Icons.logout),
                label: const Text('Logout'),
                onPressed: (){
                controller.logout();
                Navigator.pushNamed(context, MyRoutes.welcomeRoute);
              }) 
            ]
          ),
        )
    );
  }
}