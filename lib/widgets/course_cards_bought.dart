import 'package:brighter_nepal/models/courses.dart';
import 'package:brighter_nepal/pages/services/view_course_detailed.dart';
import 'package:brighter_nepal/values/styles.dart';
import 'package:brighter_nepal/widgets/loading_animation.dart';
import 'package:flutter/material.dart';

class CourseCard_Bought extends StatefulWidget {
  final course courses;

  const CourseCard_Bought({
    super.key,
    required this.courses,
  });

  @override
  State<CourseCard_Bought> createState() => _CourseCard_BoughtState();
}

class _CourseCard_BoughtState extends State<CourseCard_Bought> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 300.0,
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: const Color.fromARGB(255, 255, 255, 255),
        ),
        margin: const EdgeInsets.all(6.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: const Color.fromARGB(255, 255, 255, 255),
              ),
              child: Image.network(
                widget.courses.imageUrl,
                fit: BoxFit.cover,
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) {
                    // Image has been successfully loaded

                    return child;
                  } else {
                    // Image is still loading
                    return const Center(child: Card_Skeletan());
                  }
                },
              ),
            ),
            Container(
              alignment: Alignment.bottomLeft,
              child: Text(
                widget.courses.name,
                style: MyStyles.card_blue_text,
              ),
            ),
            Row(
              children: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => View_course_detailed(
                              id: int.parse(widget.courses.id)),
                        ),
                      );
                    },
                    child: const Text("Get Inside")),
              ],
            )
          ],
        ));
  }
}
