import 'package:brighter_nepal/pages/youtube_player.dart';
import 'package:flutter/material.dart';

class ViewVideo extends StatefulWidget {
  final String currentVideoId;
  final String title;
  final String description;

  const ViewVideo({
    super.key,
    required this.currentVideoId,
    required this.title,
    required this.description,
  });

  @override
  State<ViewVideo> createState() => _ViewVideoState();
}

class _ViewVideoState extends State<ViewVideo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: OrientationBuilder(
          builder: (context, orientation) {
            Size screenSize = MediaQuery.of(context).size;

            return Container(
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.all(10),
                    height: (orientation == Orientation.landscape)
                        ? (screenSize.height - 40)
                        : 190,
                    alignment: Alignment.topCenter,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 229, 239, 243),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: YouTubePlayerScreen(videoId: widget.currentVideoId),
                  ),
                  (orientation == Orientation.portrait)
                      ? Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.all(10),
                              height: 55 / 100 * (screenSize.height),
                              alignment: Alignment.topCenter,
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 205, 220, 226),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Column(
                                children: [
                                  Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        widget.title,
                                        style: const TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                          color:
                                              Color.fromARGB(255, 19, 18, 18),
                                          fontFamily: 'Montserrat',
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      child: Text(
                                        widget.description,
                                        style: const TextStyle(
                                          fontSize: 18,
                                          color:
                                              Color.fromARGB(255, 19, 18, 18),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.all(10),
                              height: 50,
                              alignment: Alignment.topCenter,
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 235, 241, 243),
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ],
                        )
                      : Container()
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
