import 'dart:convert';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:brighter_nepal/models/books.dart';
import 'package:brighter_nepal/models/courses.dart';
import 'package:brighter_nepal/models/questions.dart';
import 'package:brighter_nepal/values/styles.dart';
import 'package:brighter_nepal/values/user_logged_data.dart';
import 'package:brighter_nepal/values/values.dart';
import 'package:brighter_nepal/widgets/books_cards.dart';
import 'package:brighter_nepal/widgets/course_cards.dart';
import 'package:brighter_nepal/widgets/loading_animation.dart';
import 'package:brighter_nepal/widgets/mcq_model/question_card.dart';
import 'package:brighter_nepal/widgets/mock_test_cards.dart';
import 'package:brighter_nepal/widgets/mock_test_cards_online.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({
    super.key,
  });

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    loadSliderData();
    loadUserData();
  }

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
        'user_id': MySharedPreferences.getString(MyValues.USER_ID),
        'todo': "home",
        "course": MySharedPreferences.getString(MyValues.SELECTION).toString(),
      });
      print("Shared Preferences :");
      print(MySharedPreferences.getString(MyValues.SELECTION).toString());
      if (response.statusCode == 200) {
        print('Response status: ${response.statusCode}');
        var dataHome = response.body.toString();
        var decodeHome = jsonDecode(dataHome);
        var questionList = decodeHome["questions"];

        QuestionsModal.questions =
            List<Question>.from(questionList.map((e) => Question.fromJson(e)));

        print(questionList);
        var coursesList = decodeHome["courses"];
        courses_modal.courses =
            List<course>.from(coursesList.map((e) => course.fromJson(e)));

        print(coursesList);
        var booksList = decodeHome["books"];
        books_modal.books_list =
            List<books>.from(booksList.map((e) => books.fromJson(e)));

        print(booksList);

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
      backgroundColor: const Color.fromARGB(255, 243, 241, 241),
      body: SingleChildScrollView(
        child: Container(
          child: (is_loading == true)
              ? SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: const SkeletonLoading())
              : Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: MyValues.primary_color,
                        borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(16),
                            bottomRight: Radius.circular(16)),
                      ),
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height -
                          (0.77 * MediaQuery.of(context).size.height),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "WELCOME  ",
                                  style: MyStyles.big_text,
                                ),
                                const CircleAvatar(
                                  backgroundImage:
                                      AssetImage("images/logo.jpg"),
                                  radius: 32,
                                ),
                              ],
                            ),
                            Text(
                              "YOU ARE AT THE BEST ",
                              style: MyStyles.little_small_text,
                            ),
                            const Text(
                              "ENTRANCE PREPARATION PLATFORM ",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (QuestionsModal.questions.isNotEmpty)
                      Text(
                        "Best Questions Of The Day",
                        style: MyStyles.card_blue_text,
                      ),
                    (QuestionsModal.questions.isNotEmpty)
                        ? QuestionCard(
                            question: QuestionsModal.questions[0],
                          )
                        : Text(
                            "No Questions Found",
                            style: MyStyles.card_blue_text,
                          ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 6),
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        "Our Books",
                        style: MyStyles.card_blue_text,
                      ),
                    ),
                    Container(
                      height: (courses_modal.courses.isEmpty) ? 40 : 320,
                      padding: const EdgeInsets.all(6),
                      child: ListView.builder(
                        itemCount: (books_modal.books_list.isEmpty)
                            ? 1
                            : books_modal.books_list.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return (books_modal.books_list.isNotEmpty)
                              ? BooksCard(book: books_modal.books_list[index])
                              : const Text("Nothing Found");
                        },
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 10),
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        "Our Courses",
                        style: MyStyles.card_blue_text,
                      ),
                    ),
                    Container(
                      height: (courses_modal.courses.isEmpty) ? 40 : 330,
                      padding: const EdgeInsets.all(10),
                      child: ListView.builder(
                        itemCount: (courses_modal.courses.isEmpty)
                            ? 1
                            : courses_modal.courses.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return (courses_modal.courses.isNotEmpty)
                              ? CourseCard(
                                  courses: courses_modal.courses[index])
                              : const Text("Nothing Found");
                        },
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 10),
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        "Mock Tests - Online",
                        style: MyStyles.card_blue_text,
                      ),
                    ),
                    Container(
                      height: (courses_modal.courses.isEmpty) ? 40 : 300,
                      padding: const EdgeInsets.all(10),
                      child: ListView.builder(
                        itemCount: (courses_modal.courses.isEmpty)
                            ? 1
                            : courses_modal.courses.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return (courses_modal.courses.isNotEmpty)
                              ? MockTestCardsOnline(
                                  courses: courses_modal.courses[index])
                              : const Text("Nothing Found");
                        },
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 10),
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        "Mock Tests - Offline",
                        style: MyStyles.card_blue_text,
                      ),
                    ),
                    Container(
                      height: (courses_modal.courses.isEmpty) ? 40 : 300,
                      padding: const EdgeInsets.all(10),
                      child: ListView.builder(
                        itemCount: (courses_modal.courses.isEmpty)
                            ? 1
                            : courses_modal.courses.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return (courses_modal.courses.isNotEmpty)
                              ? MockTestCards(
                                  courses: courses_modal.courses[index])
                              : const Text("Nothing Found");
                        },
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
