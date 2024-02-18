import 'package:brighter_nepal/models/courses.dart';
import 'package:brighter_nepal/pages/services/chat_view_page.dart';
import 'package:brighter_nepal/pages/services/view_course_detailed.dart';
import 'package:brighter_nepal/values/styles.dart';
import 'package:brighter_nepal/values/values.dart';
import 'package:brighter_nepal/widgets/loading_animation.dart';
import 'package:flutter/material.dart';

class list_options extends StatefulWidget {
  final Map<String, dynamic> options; // Adjust the type based on your data

  const list_options({
    Key? key, // Use 'Key?' instead of 'var key'
    required this.options,
  }) : super(key: key);

  @override
  State<list_options> createState() => _list_optionsState();
}

class _list_optionsState extends State<list_options> {
  @override
  Widget build(BuildContext context) {
    var arr = widget.options;
    return Container(
      width: 300.0,
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: MyValues.primary_color),
      margin: const EdgeInsets.all(6.0),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: const Color.fromARGB(255, 255, 255, 255),
            ),
          ),
          Text(
            arr['option_name'],
            style: TextStyle(fontSize: 24, color: Colors.white),
          ),
          Container(
            alignment: Alignment.bottomLeft,
            child: Column(
              children: [
                Text(
                  arr["description"],
                  style: TextStyle(fontSize: 14, color: Colors.white),
                ),
              ],
            ),
          ),
          Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Chat_view_page(
                          id: int.parse(arr['id'].toString()),
                          title: arr['option_name']),
                    ),
                  );
                },
                child: const Text("Get Inside"),
              ),
            ],
          )
        ],
      ),
    );
  }
}
