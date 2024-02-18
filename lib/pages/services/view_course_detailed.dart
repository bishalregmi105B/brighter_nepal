import 'dart:convert';
import 'dart:io';
import 'package:brighter_nepal/widgets/course_cards.dart';
import 'package:brighter_nepal/widgets/course_cards_bought.dart';
import 'package:brighter_nepal/widgets/loading_animation.dart';
import 'package:brighter_nepal/widgets/services/list_options.dart';
import 'package:http/http.dart' as http;
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:brighter_nepal/models/courses.dart';
import 'package:brighter_nepal/values/styles.dart';
import 'package:brighter_nepal/values/user_logged_data.dart';
import 'package:brighter_nepal/values/values.dart';
import 'package:flutter/material.dart';

class View_course_detailed extends StatefulWidget {
  final int id;
  const View_course_detailed({super.key, required this.id});

  @override
  State<View_course_detailed> createState() => _View_course_detailedState();
}

class _View_course_detailedState extends State<View_course_detailed> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadSliderData();
  }

  List<Map<String, dynamic>> coursesList = [];

  String selected = "";
  Future<void> loadUserData() async {
    setState(() {
      selected = MySharedPreferences.getString(MyValues.SELECTION);
    });
  }

  bool is_loading = true;
  loadSliderData() async {
    var url = Uri.https(MyValues.server_url, MyValues.home_url);
    try {
      var response = await http.post(url, body: {
        'id': MySharedPreferences.getString(MyValues.USER_ID),
        'todo': "services_course_detailed",
        'course_id': "${widget.id}",
        "course": MySharedPreferences.getString(MyValues.SELECTION).toString(),
      });
      print(
          "Shared Preferences : ${MySharedPreferences.getString(MyValues.USER_ID)}");
      print(MySharedPreferences.getString(MyValues.SELECTION).toString());
      if (response.statusCode == 200) {
        courses_modal.courses.clear();
        print('Response status: ${response.statusCode}');
        var dataHome = response.body.toString();
        var decodeHome = jsonDecode(dataHome);

        coursesList = (decodeHome["services_course_detailed"] as List<dynamic>)
            .cast<Map<String, dynamic>>();

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
    print(widget.id);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: MyValues.primary_color,
          title: const Text(
            'BRIGHTER NEPAL ',
            style: TextStyle(color: Colors.white),
          ),
          leading: Image.asset("images/logo.jpg"),
        ),
        body: SingleChildScrollView(
            child: (is_loading == false)
                ? Container(
                    height: MediaQuery.of(context).size.height,
                    child: ListView.builder(
                        itemCount: coursesList.length,
                        itemBuilder: (context, index) {
                          return (coursesList.length > 0)
                              ? list_options(options: coursesList[index])
                              : Text("No Data Found");
                        }))
                : SkeletonLoading()));
  }
}
