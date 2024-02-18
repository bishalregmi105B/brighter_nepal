import 'dart:convert';

import 'package:brighter_nepal/values/myroutes.dart';
import 'package:brighter_nepal/values/styles.dart';
import 'package:brighter_nepal/widgets/loading_animation.dart';
import "package:http/http.dart" as http;
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:brighter_nepal/values/values.dart';
import 'package:brighter_nepal/widgets/input_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formkey = GlobalKey<FormState>();
  TextEditingController contact = TextEditingController();
  TextEditingController fullname = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController repeat_pass = TextEditingController();
  TextEditingController email = TextEditingController();

  movetoHome(BuildContext context) async {
    print("Form Validated");
    if (_formkey.currentState!.validate()) {
      if (password.text == repeat_pass.text) {
        setState(() {
          is_logging = true;
        });
        perform_signup(email.text, password.text, contact.text, fullname.text);
      } else {
        setState(() {
          is_logging = false;
        });
        final snackBar = SnackBar(
          /// need to set following properties for best effect of awesome_snackbar_content
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: const Color.fromARGB(0, 204, 107, 107),
          content: AwesomeSnackbarContent(
            title: 'Password Not Matched',
            message: "Make Sure you Enter Same Password in Both Fields",

            /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
            contentType: ContentType.warning,
          ),
        );
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
      }
    } else {
      print("Else");
      setState(() {
        is_logging = false;
      });
      final snackBar = SnackBar(
        /// need to set following properties for best effect of awesome_snackbar_content
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: const Color.fromARGB(0, 204, 107, 107),
        content: AwesomeSnackbarContent(
          title: 'Enter All Details',
          message: "Make Sure you Enter All The Details",

          /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
          contentType: ContentType.warning,
        ),
      );
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
    }
  }

  perform_signup(
      String email, String password, String phone, String name) async {
    var url = Uri.https(MyValues.server_url, MyValues.signup);
    try {
      var response = await http.post(url, body: {
        'email': email,
        'password': password,
        'phone': phone,
        'name': name
      });
      if (response.statusCode == 200) {
        print('Response status: ${response.statusCode}');
        print('Response body: ${response.body}');
        var decodeData = jsonDecode(response.body);
        print(decodeData["response"]);
        if (decodeData["response"] == "failure") {
          final snackBar = SnackBar(
            /// need to set following properties for best effect of awesome_snackbar_content
            elevation: 0,
            behavior: SnackBarBehavior.floating,
            backgroundColor: const Color.fromARGB(0, 204, 107, 107),
            content: AwesomeSnackbarContent(
              title: 'User Already Exists',
              message: (decodeData["message"] != null)
                  ? decodeData["message"]
                  : "Something Went Wrong",

              /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
              contentType: ContentType.warning,
            ),
          );
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(snackBar);
          setState(() {
            is_logging = false;
          });

          // Simple snackbar
        } else {
          // Obtain shared preferences.

          final snackBar = SnackBar(
            /// need to set following properties for best effect of awesome_snackbar_content
            elevation: 0,
            duration: const Duration(seconds: 7),
            behavior: SnackBarBehavior.floating,
            backgroundColor: const Color.fromARGB(0, 204, 107, 107),
            content: AwesomeSnackbarContent(
              title: 'Thanks For Joining',
              message:
                  "Thanks For Joining Us. Please Re-Enter Here To Get logged In",

              /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
              contentType: ContentType.warning,
            ),
          );
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(snackBar);
          await Navigator.pushReplacementNamed(context, MyRoutes.login);
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

  bool is_logging = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(color: Color.fromRGBO(232, 232, 232, 255)),
        child: Stack(children: [
          Positioned(
            child: Container(
                height: 220,
                margin: const EdgeInsets.all(0),
                padding: const EdgeInsets.only(top: 20, left: 20),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: const Color.fromRGBO(7, 17, 98, 10),
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          CupertinoIcons.back,
                          size: 40,
                          color: Colors.white,
                        )),
                    Text(
                      "CREATE YOUR",
                      style: MyStyles.big_text,
                    ),
                    Text(
                      "ACCOUNT",
                      style: MyStyles.big_text,
                    )
                  ],
                )),
          ),
          Positioned(
            top: 260,
            left: 20,
            right: 20,
            child: Form(
              key: _formkey,
              child: SizedBox(
                height: MediaQuery.of(context).size.height - 220,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    InputField(
                      controller: contact,
                      hint_text: "Enter Your Contact Number",
                      prefixIcon: const Icon(CupertinoIcons.phone),
                      obsc: false,
                    ),
                    InputField(
                      controller: email,
                      hint_text: "Enter Your Email",
                      prefixIcon: const Icon(CupertinoIcons.mail),
                      obsc: false,
                    ),
                    InputField(
                      controller: fullname,
                      hint_text: "Enter Your Full Name",
                      prefixIcon: const Icon(CupertinoIcons.person),
                      obsc: false,
                    ),
                    InputField(
                      controller: password,
                      hint_text: "Enter Password",
                      prefixIcon: const Icon(CupertinoIcons.lock),
                      obsc: true,
                    ),
                    InputField(
                      controller: repeat_pass,
                      hint_text: "Re-Type Password",
                      prefixIcon: const Icon(CupertinoIcons.lock),
                      obsc: true,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: const Color.fromRGBO(7, 17, 98, 10),
                          borderRadius: BorderRadius.circular(20)),
                      width: MediaQuery.of(context).size.width - 100,
                      child: ElevatedButton(
                          onPressed: () {
                            movetoHome(context);
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: const Color.fromRGBO(7, 17, 98, 10)),
                          child: (is_logging == false)
                              ? const Text(
                                  "Create Account",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 24),
                                )
                              : const LoadingAnimation()),
                    )
                  ],
                ),
              ),
            ),
          )
        ]),
      ),
    );
  }
}
