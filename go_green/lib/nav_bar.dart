import 'package:flutter/material.dart';
import 'package:go_green/pages/about_page.dart';
import 'package:go_green/pages/task_page.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
   int _selectedIndex=0;
  final pages=[
    TaskPage(),
    AboutPage(),
  ];

  @override
  Widget build(BuildContext context){
   
   return Scaffold(
      body: Center(
             child: pages[_selectedIndex],
           ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: GNav(
            tabBorderRadius: 10,
            tabBackgroundColor: Colors.grey[100]!,
            rippleColor: Colors.grey[100]!,
            gap: 8,
            activeColor: Colors.lightGreen,
            color: Colors.lightGreen,
            iconSize: 24,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            tabs: const [
              GButton(
                icon: Icons.home,
                text: 'Home',
              ),
              GButton(
                icon: Icons.people,
                text: 'About',
              ),
            ],
            selectedIndex: _selectedIndex,
            onTabChange: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
          ),
        ),
      ),
     
         );
  }
  
}