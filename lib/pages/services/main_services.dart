import 'dart:convert';
import 'dart:io';
import 'package:brighter_nepal/widgets/course_cards.dart';
import 'package:brighter_nepal/widgets/course_cards_bought.dart';
import 'package:brighter_nepal/widgets/loading_animation.dart';
import 'package:http/http.dart' as http;
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:brighter_nepal/models/courses.dart';
import 'package:brighter_nepal/values/styles.dart';
import 'package:brighter_nepal/values/user_logged_data.dart';
import 'package:brighter_nepal/values/values.dart';
import 'package:flutter/material.dart';

class Main_services extends StatefulWidget {
  const Main_services({super.key});

  @override
  State<Main_services> createState() => _Main_servicesState();
}

class _Main_servicesState extends State<Main_services> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadSliderData();
  }

  String selected = "";

  Future<void> loadUserData() async {
    setState(() {
      selected = MySharedPreferences.getString(MyValues.SELECTION);
    });
  }

  bool is_loading = true;
  loadSliderData() async {
    courses_modal.courses.clear();
    var url = Uri.https(MyValues.server_url, MyValues.home_url);
    try {
      var response = await http.post(url, body: {
        'id': MySharedPreferences.getString(MyValues.USER_ID),
        'todo': "services",
        "course": MySharedPreferences.getString(MyValues.SELECTION).toString(),
      });
      print(
          "Shared Preferences : ${MySharedPreferences.getString(MyValues.USER_ID)}");
      print(MySharedPreferences.getString(MyValues.SELECTION).toString());
      if (response.statusCode == 200) {
        print('Response status: ${response.statusCode}');
        var dataHome = response.body.toString();
        var decodeHome = jsonDecode(dataHome);

        var coursesList = decodeHome["services"];

        courses_modal.courses =
            List<course>.from(coursesList.map((e) => course.fromJson(e)));

        print(coursesList);

        setState(() {
          is_loading = false;
        });
      }
    } catch (e) {
      print(e.toString());
      setState(() {
        is_loading = false;
        final snackBar = SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: const Color.fromARGB(0, 204, 107, 107),
          content: AwesomeSnackbarContent(
            title: 'We Could not Load Data ',
            message:
                'Sorry We could not load data from Server. Please Get Connected to Internet or Our Server Error may be occoured',
            contentType: ContentType.failure,
          ),
        );
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: (is_loading == false)
                ? Container(
                    height: MediaQuery.of(context).size.height,
                    child: ListView.builder(
                        itemCount: (courses_modal.courses.length > 0)
                            ? courses_modal.courses.length
                            : 1,
                        itemBuilder: (context, index) {
                          return (courses_modal.courses.length > 0)
                              ? CourseCard_Bought(
                                  courses: courses_modal.courses[index])
                              : Center(
                                  child: Container(
                                    padding: EdgeInsets.all(10),
                                    child: Text(
                                      "Looks Like You Havenot Bought Any Courses 😭😭",
                                      style: MyStyles.card_blue_text,
                                    ),
                                  ),
                                );
                        }))
                : SkeletonLoading()));
  }
}
