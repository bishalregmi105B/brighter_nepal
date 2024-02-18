import 'package:brighter_nepal/pages/free_study.dart';
import 'package:brighter_nepal/pages/home.dart';
import 'package:brighter_nepal/pages/services/main_services.dart';
import 'package:brighter_nepal/pages/user_pages/profile.dart';
import 'package:brighter_nepal/values/values.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home_Page extends StatefulWidget {
  const Home_Page({super.key});

  @override
  _Home_PageState createState() => _Home_PageState();
}

class _Home_PageState extends State<Home_Page> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    Home(),
    FreeStudy(),
    Main_services(),
    const Text('Contact Page'),
    ProfilePage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyValues.primary_color,
        title: const Text(
          'BRIGHTER NEPAL ',
          style: TextStyle(color: Colors.white),
        ),
        leading: Image.asset("images/logo.jpg"),
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        fixedColor: MyValues.primary_color,
        useLegacyColorScheme: false,
        backgroundColor:
            MyValues.primary_color, // Set the background color here
        currentIndex: _currentIndex,
        unselectedItemColor: Colors.black,
        // selectedItemColor: Colors.black,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.book),
            label: 'Free Study',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.video_call),
            label: 'Services',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.mail),
            label: 'Contact',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.person_circle),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
