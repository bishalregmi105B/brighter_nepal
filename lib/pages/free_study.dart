import 'dart:convert';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:brighter_nepal/helper/filter.dart';
import 'package:brighter_nepal/models/videos_modal.dart';
import 'package:brighter_nepal/pages/view_videos.dart';
import 'package:brighter_nepal/values/styles.dart';
import 'package:brighter_nepal/values/user_logged_data.dart';
import 'package:brighter_nepal/values/values.dart';
import 'package:brighter_nepal/widgets/free_study/video_cards.dart';
import 'package:brighter_nepal/widgets/loading_animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FreeStudy extends StatefulWidget {
  const FreeStudy({super.key});

  @override
  State<FreeStudy> createState() => _FreeStudyState();
}

class _FreeStudyState extends State<FreeStudy> {
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

  late List<Videos> filteredVideos_colleges = [];
  late List<Videos> filteredVideos_podcasts = [];
  late List<Videos> filteredVideos_guidance = [];
  late List<Videos> filteredVideos_studyvideos = [];
  bool is_loading = true;
  loadSliderData() async {
    var url = Uri.https(MyValues.server_url, MyValues.home_url);
    try {
      var response = await http.post(url, body: {
        'user_id': MySharedPreferences.getString(MyValues.USER_ID),
        'todo': "free_study",
        "course": MySharedPreferences.getString(MyValues.SELECTION).toString(),
      });
      print("Shared Preferences :");
      print(MySharedPreferences.getString(MyValues.SELECTION).toString());
      if (response.statusCode == 200) {
        print('Response status: ${response.statusCode}');
        var dataHome = response.body.toString();
        var decodeHome = jsonDecode(dataHome);
        var questionList = decodeHome["about_colleges"];

        Videos_Modal.Videoss =
            List<Videos>.from(questionList.map((e) => Videos.fromJson(e)));

        filteredVideos_colleges =
            filterVideosByType(Videos_Modal.Videoss, 'about_colleges');
        var podcastsList = decodeHome["podcasts"];
        Videos_Modal.Videoss =
            List<Videos>.from(questionList.map((e) => Videos.fromJson(e)));

        filteredVideos_podcasts =
            filterVideosByType(Videos_Modal.Videoss, 'podcasts');

        var guidanceList = decodeHome["guidance"];
        Videos_Modal.Videoss =
            List<Videos>.from(questionList.map((e) => Videos.fromJson(e)));

        filteredVideos_guidance =
            filterVideosByType(Videos_Modal.Videoss, 'guidance');

        var studyVideos = decodeHome["study_videos"];
        Videos_Modal.Videoss =
            List<Videos>.from(questionList.map((e) => Videos.fromJson(e)));

        filteredVideos_studyvideos =
            filterVideosByType(Videos_Modal.Videoss, 'study_videos');
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
      backgroundColor: const Color.fromARGB(31, 245, 243, 243),
      body: SingleChildScrollView(
          child: (is_loading != true)
              ? Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        color: MyValues.primary_color,
                        padding: const EdgeInsets.only(left: 6),
                        alignment: Alignment.bottomLeft,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "About Colleges",
                              style: MyStyles.little_small_text,
                            ),
                            IconButton(
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => List_Videos(
                                      what: "about_colleges",
                                      title: "About Colleges",
                                    ),
                                  ));
                                },
                                icon: const Icon(
                                  CupertinoIcons.arrow_right,
                                  color: Colors.white,
                                ))
                          ],
                        ),
                      ),
                      Container(
                        height: (filteredVideos_colleges.isEmpty) ? 40 : 290,
                        padding: const EdgeInsets.all(6),
                        child: ListView.builder(
                          itemCount: (filteredVideos_colleges.isEmpty) ? 1 : 3,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return (filteredVideos_colleges.isNotEmpty)
                                ? VideoCards(
                                    video_li: filteredVideos_colleges[index])
                                : const Text("Nothing Found");
                          },
                        ),
                      ),
                      Container(
                        color: MyValues.primary_color,
                        padding: const EdgeInsets.only(left: 6),
                        alignment: Alignment.bottomLeft,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Study Videos",
                              style: MyStyles.little_small_text,
                            ),
                            IconButton(
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => List_Videos(
                                      what: "study_videos",
                                      title: "Study Videos",
                                    ),
                                  ));
                                },
                                icon: const Icon(
                                  CupertinoIcons.arrow_right,
                                  color: Colors.white,
                                ))
                          ],
                        ),
                      ),
                      Container(
                        height: (filteredVideos_studyvideos.isEmpty) ? 40 : 290,
                        padding: const EdgeInsets.all(6),
                        child: ListView.builder(
                          itemCount:
                              (filteredVideos_studyvideos.isEmpty) ? 1 : 3,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return (filteredVideos_studyvideos.isNotEmpty)
                                ? VideoCards(
                                    video_li: filteredVideos_studyvideos[index])
                                : const Text("Nothing Found");
                          },
                        ),
                      ),
                      Container(
                        color: MyValues.primary_color,
                        padding: const EdgeInsets.only(left: 6),
                        alignment: Alignment.bottomLeft,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Guidance",
                              style: MyStyles.little_small_text,
                            ),
                            IconButton(
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => List_Videos(
                                      what: "guidance",
                                      title: "Guidance",
                                    ),
                                  ));
                                },
                                icon: const Icon(
                                  CupertinoIcons.arrow_right,
                                  color: Colors.white,
                                ))
                          ],
                        ),
                      ),
                      Container(
                        height: (filteredVideos_guidance.isEmpty) ? 40 : 290,
                        padding: const EdgeInsets.all(6),
                        child: ListView.builder(
                          itemCount: (filteredVideos_guidance.isEmpty) ? 1 : 3,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return (filteredVideos_guidance.isNotEmpty)
                                ? VideoCards(
                                    video_li: filteredVideos_guidance[index])
                                : const Text("Nothing Found");
                          },
                        ),
                      ),
                      Container(
                        color: MyValues.primary_color,
                        padding: const EdgeInsets.only(left: 6),
                        alignment: Alignment.bottomLeft,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Podcasts",
                              style: MyStyles.little_small_text,
                            ),
                            IconButton(
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => List_Videos(
                                      what: "podcasts",
                                      title: " Podcasts",
                                    ),
                                  ));
                                },
                                icon: const Icon(
                                  CupertinoIcons.arrow_right,
                                  color: Colors.white,
                                ))
                          ],
                        ),
                      ),
                      Container(
                        height: (filteredVideos_podcasts.isEmpty) ? 40 : 290,
                        padding: const EdgeInsets.all(6),
                        child: ListView.builder(
                          itemCount: (filteredVideos_podcasts.isEmpty) ? 1 : 3,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return (filteredVideos_podcasts.isNotEmpty)
                                ? VideoCards(
                                    video_li: filteredVideos_podcasts[index])
                                : const Text("Nothing Found");
                          },
                        ),
                      ),
                    ],
                  ),
                )
              : const SkeletonLoading()),
    );
  }
}
