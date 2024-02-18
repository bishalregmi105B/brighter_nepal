import 'dart:async';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:brighter_nepal/values/myroutes.dart';
import 'package:brighter_nepal/values/values.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    check_loggedin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 203, 108, 230),
        body: Center(
            child: DefaultTextStyle(
          style: const TextStyle(
            fontSize: 40.0,
          ),
          child: AnimatedTextKit(
            animatedTexts: [
              WavyAnimatedText('BRIGHTER NEPAL'),
              WavyAnimatedText('THE BEST EDUCATION PLATFORM'),
            ],
            isRepeatingAnimation: true,
            onTap: () {
              print("Tap Event");
            },
          ),
        )));
  }

  void check_loggedin() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool? loggedin = prefs.getBool(MyValues.LOGGED_IN);
    final String? selected = prefs.getString(MyValues.SELECTION);
    if (loggedin == true) {
      Timer(const Duration(seconds: 5), () {
        if (selected != null || selected != "") {
          Navigator.pushReplacementNamed(context, MyRoutes.main);
        } else {
          Navigator.pushReplacementNamed(context, MyRoutes.home);
        }
      });
    } else {
      Timer(const Duration(seconds: 5), () {
        Navigator.pushReplacementNamed(context, MyRoutes.login);
      });
    }
  }
}
