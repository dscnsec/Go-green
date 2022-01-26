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
    const TaskPage(),
    const AboutPage(),
  ];

  final PageController _pageController= PageController(initialPage: 0, keepPage: true);

  @override
  Widget build(BuildContext context){

   return Scaffold(
      body: PageView(
        physics: const BouncingScrollPhysics(),
        controller: _pageController,
        onPageChanged: (index){
          setState(()=> _selectedIndex=index);
        },
        children: pages,
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: GNav(
            tabBorderRadius: 10,
            tabBackgroundColor: Colors.white,
            rippleColor: Colors.white,
            gap: 8,
            activeColor: Colors.lightGreen,
            color: Colors.lightGreen,
            tabShadow: [BoxShadow(color: Colors.grey.withOpacity(0.05), blurRadius: 8)],
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
              
            _selectedIndex=index;
            _pageController.animateToPage(_selectedIndex, duration: const Duration(milliseconds: 500), curve: Curves.decelerate);

            }
          ),
        ),
      ),
     
         );
  }
}