import 'package:brighter_nepal/helper/launcher_functions.dart';
import 'package:brighter_nepal/values/myroutes.dart';
import 'package:brighter_nepal/values/styles.dart';
import 'package:brighter_nepal/values/values.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Selection_Initial extends StatefulWidget {
  const Selection_Initial({super.key});

  @override
  State<Selection_Initial> createState() => _SelectionInitialState();
}

class _SelectionInitialState extends State<Selection_Initial> {
  List<String> mySet = [
    'Bridge Course',
    'CTEVT Entrance',
    'Class 11',
    'Class 12',
    'SEE'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(244, 246, 255, 255),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 200,
              decoration: BoxDecoration(
                color: MyValues.primary_color,
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 40),
                  Text(
                    "WELCOME TO ",
                    style: MyStyles.big_text,
                  ),
                  Text(
                    "TO BRIGHTER NEPAL",
                    style: MyStyles.little_small_text,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text(
                "Categories",
                style: GoogleFonts.poppins(
                  textStyle: MyStyles.little_small_text,
                  color: Colors.black,
                ),
              ),
            ),
            Expanded(
              // Wrap the GridView in an Expanded widget
              child: GridView.count(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                crossAxisCount: 3,
                children: List.generate(5, (index) {
                  return InkWell(
                    onTap: () async {
                      await handle_selection_initial(mySet[index], index);
                      Navigator.pushReplacementNamed(context, MyRoutes.main);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14)),
                      margin: const EdgeInsets.all(4),
                      width: 100,
                      height: 100,
                      child: Center(
                        child: Text(mySet[index],
                            textAlign: TextAlign.center,
                            overflow: TextOverflow
                                .ellipsis, // Handles overflow with ellipsis
                            maxLines: 2, // Restricts to a maximum of 2 lines
                            style: MyStyles.card_blue_text),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
