import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:to_do_now/pages/todo_home.dart';
import 'package:to_do_now/pages/todo_notif.dart';
import 'package:to_do_now/pages/todo_tasks.dart';


class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key});
  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  int currentIndex = 0;

  final List<Widget> screens = [
    TodoHome(),
    TodoTasks(),
   TodoNotifications(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
appBar: AppBar(
  backgroundColor: Color(0xFFF2F5FF),

),
      body: screens[currentIndex],
      bottomNavigationBar:
      Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GNav(
            gap: 8,
            backgroundColor: Colors.white,
            color: Colors.black,
            activeColor: Colors.white,
            tabBackgroundColor: Colors.blueAccent,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            selectedIndex: currentIndex,
            onTabChange: (index) {
              setState(() {
                currentIndex = index;
              });
            },
            tabs:  [
              GButton(icon: Icons.home, text: 'Home', textStyle: TextStyle(fontFamily: 'poppins',color: Colors.white),),
              GButton(icon: Icons.calendar_month, text: 'Tasks',textStyle: TextStyle(fontFamily: 'poppins',color: Colors.white),),
              GButton(icon: Icons.notifications_none, text: 'Notifications',textStyle: TextStyle(fontFamily: 'poppins',color: Colors.white),),

            ],
          ),
        ),
      ),

    );
  }
}
