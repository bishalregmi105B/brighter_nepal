import 'dart:convert';
import 'package:brighter_nepal/widgets/bottom_sheet.dart';
import 'package:brighter_nepal/widgets/loading_animation.dart';
import 'package:http/http.dart' as http;
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:brighter_nepal/values/myroutes.dart';
import 'package:brighter_nepal/values/values.dart';
import 'package:brighter_nepal/widgets/input_field.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController number = TextEditingController();
  TextEditingController password = TextEditingController();
  bool value = false;
  bool is_logging = false;

  login_clicked() {
    if (number.text != "" && password.text != "") {
      setState(() {
        is_logging = true;
        perform_login(number.text, password.text);
      });
    } else {
      final snackBar = SnackBar(
        /// need to set following properties for best effect of awesome_snackbar_content
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: const Color.fromARGB(0, 204, 107, 107),
        content: AwesomeSnackbarContent(
          title: 'Fill All Credentials',
          message: 'Please Fill All User Credentials',

          /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
          contentType: ContentType.warning,
        ),
      );
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
    }
  }

  perform_login(String email, String password) async {
    var url = Uri.https(MyValues.server_url, MyValues.app_login);
    try {
      var response =
          await http.post(url, body: {'number': email, 'password': password});
      if (response.statusCode == 200) {
        print('Response status: ${response.statusCode}');
        print('Response body: ${response.body}');
        var decodeData = jsonDecode(response.body);
        print(decodeData["response"]);
        if (decodeData["response"] == "failure") {
          setState(() {
            is_logging = false;
          });
          final snackBar = SnackBar(
            /// need to set following properties for best effect of awesome_snackbar_content
            elevation: 0,
            behavior: SnackBarBehavior.floating,
            backgroundColor: const Color.fromARGB(0, 204, 107, 107),
            content: AwesomeSnackbarContent(
              title: 'Wrong User Credentials ',
              message: 'Please Give Correct User Credentials',

              /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
              contentType: ContentType.warning,
            ),
          );
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(snackBar);
          // Simple snackbar
        } else {
          // Obtain shared preferences.
          var res_ = decodeData["response"];
          print(res_);
          final String name = res_['username'];
          final String userId = res_['id'];
          final String phone = res_['contactno'];
          final String email = res_['email'];
          final String imageUrl = res_['profile_img_url'];

          final SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setBool(MyValues.LOGGED_IN, true);
          prefs.setString(MyValues.USER_ID, userId);
          prefs.setString(MyValues.NAME, name);
          prefs.setString(MyValues.PHONE, phone);
          prefs.setString(MyValues.EMAIL, email);
          prefs.setString(MyValues.IMG, imageUrl);
          await Navigator.pushReplacementNamed(context, MyRoutes.home);

          setState(() {
            is_logging = false;
          });
          //
        }
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: BoxDecoration(
          color: MyValues.primary_color,
        ),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Positioned(
              child: Container(
                padding: const EdgeInsets.all(100),
                height: MediaQuery.of(context).size.height - 300,
                decoration: BoxDecoration(
                    color: const Color.fromRGBO(243, 239, 239, 10.004),
                    borderRadius: BorderRadius.circular(20)),
                child: Stack(children: [
                  Container(
                    child: ClipOval(
                      child: Image.asset("images/logo.jpg"),
                    ),
                  )
                ]),
              ),
            ),
            Positioned(
              top: 300,
              left: 30,
              right: 30,
              child: Center(
                child: Container(
                  child: const Text(
                    "BRIGHTER NEPAL",
                    style: TextStyle(
                        fontSize: 34,
                        color: Color.fromRGBO(7, 17, 98, 10),
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 350,
              left: 25,
              right: 25,
              child: Container(
                padding: const EdgeInsets.all(20),
                height: 395,
                width: 350,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                child: Column(children: [
                  InputField(
                      controller: number,
                      hint_text: "Enter Your Number",
                      obsc: false,
                      prefixIcon: const Icon(Icons.supervised_user_circle)),
                  InputField(
                      controller: password,
                      obsc: true,
                      hint_text: "Enter Password",
                      prefixIcon: const Icon(Icons.supervised_user_circle)),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Row(
                      children: [
                        Checkbox(
                          value: value,
                          onChanged: (bool? val) {
                            setState(() {
                              value = val ?? false;
                            });
                          },
                        ),
                        const Text("Remember Me")
                      ],
                    ),
                  ),
                  Container(
                    width: 250,
                    decoration: BoxDecoration(
                        color: const Color.fromRGBO(7, 17, 98, 10),
                        borderRadius: BorderRadius.circular(20)),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromRGBO(7, 17, 98, 10),
                        ),
                        child: (is_logging == false)
                            ? const Text(
                                "Login",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 22),
                              )
                            : const LoadingAnimation(),
                        onPressed: () {
                          login_clicked();
                        }),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: 250,
                    decoration: BoxDecoration(
                        color: const Color.fromRGBO(7, 17, 98, 10),
                        borderRadius: BorderRadius.circular(20)),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromRGBO(7, 17, 98, 10),
                        ),
                        child: const Text(
                          "Create Account",
                          style: TextStyle(color: Colors.white, fontSize: 22),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, MyRoutes.signup);
                        }),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return const CustomBottomSheet();
                        },
                      );
                    },
                    child: const Text('Get Help'),
                  ),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
