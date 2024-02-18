import 'package:brighter_nepal/call_service.dart';
import 'package:brighter_nepal/home_page.dart';
import 'package:brighter_nepal/selection_initial.dart';
import 'package:brighter_nepal/pages/user_pages/login.dart';
import 'package:brighter_nepal/pages/user_pages/signup.dart';
import 'package:brighter_nepal/splash_pages/splash.dart';
import 'package:brighter_nepal/values/myroutes.dart';
import 'package:brighter_nepal/values/mythemes.dart';
import 'package:brighter_nepal/values/user_logged_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MySharedPreferences.init();
  runApp(const BrighterNepal());
}

class BrighterNepal extends StatelessWidget {
  const BrighterNepal({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return GetMaterialApp(
      debugShowCheckedModeBanner: true,
      themeMode: ThemeMode.system,
      theme: MyThemes.lightTheme(context),
      darkTheme: MyThemes.darkTheme(context),
      routes: {
        MyRoutes.login: (context) => const Login(),
        MyRoutes.home: (context) => const Selection_Initial(),
        MyRoutes.main: (context) => const Home_Page(),
        MyRoutes.splash: (context) => const Splash(),
        MyRoutes.signup: (context) => const SignUp(),
      },
    );
  }
}
