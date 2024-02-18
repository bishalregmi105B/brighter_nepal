import 'package:brighter_nepal/helper/filter.dart';
import 'package:brighter_nepal/models/videos_modal.dart';
import 'package:brighter_nepal/values/values.dart';
import 'package:brighter_nepal/widgets/free_study/video_cards.dart';
import 'package:flutter/material.dart';

class List_Videos extends StatefulWidget {
  final String what;
  final String title;
  const List_Videos({super.key, required this.what, required this.title});

  @override
  State<List_Videos> createState() => _List_VideosState();
}

class _List_VideosState extends State<List_Videos> {
  late List<Videos> filtered_videos = [];

  @override
  void initState() {
    super.initState();
    initializeFilteredVideos();
  }

  void initializeFilteredVideos() {
    if (widget.what == "about_colleges") {
      filtered_videos =
          filterVideosByType(Videos_Modal.Videoss, 'about_colleges');
    } else if (widget.what == "study_videos") {
      filtered_videos =
          filterVideosByType(Videos_Modal.Videoss, 'study_videos');
      // Handle other cases if needed
    } else if (widget.what == "podcasts") {
      filtered_videos = filterVideosByType(Videos_Modal.Videoss, 'podcasts');
    } else {
      filtered_videos = filterVideosByType(Videos_Modal.Videoss, 'guidance');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyValues.primary_color,
        title: Text(
          "BRIGHTER NEPAL - ${widget.title}",
          style: TextStyle(color: Colors.white),
        ),
        leading: Image.asset("images/logo.jpg"),
      ),
      body: Container(
        child: ListView.builder(
          itemCount: filtered_videos.length,
          itemBuilder: (context, index) {
            print(index);
            return VideoCards(video_li: filtered_videos[index]);
          },
        ),
      ),
    );
  }
}
