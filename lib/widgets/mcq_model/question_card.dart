import 'package:brighter_nepal/models/questions.dart';
import 'package:flutter/material.dart';
import 'option_tile.dart';

class QuestionCard extends StatelessWidget {
  final Question question;

  const QuestionCard({super.key, required this.question});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              question.name,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                for (int i = 0; i < question.options.length; i++)
                  OptionTile(
                    option: question.options[i],
                    correctAnswerIndex: question.correctAnswerIndex,
                    currentIndex: i,
                    onTap: () {
                      // Handle option selection
                      print("Selected option: ${i + 1}");
                    },
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
