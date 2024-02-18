import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class BoldSLidingText extends StatelessWidget {
  final String initial_text;
  final String first_text;
  final String second_text;
  final String third_text;
  const BoldSLidingText(
      {super.key,
      required this.initial_text,
      required this.first_text,
      required this.second_text,
      required this.third_text});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        const SizedBox(width: 20.0, height: 100.0),
        const Text(
          'Be',
          style: TextStyle(fontSize: 43.0),
        ),
        const SizedBox(width: 20.0, height: 100.0),
        DefaultTextStyle(
          style: const TextStyle(
            fontSize: 40.0,
            fontFamily: 'Horizon',
          ),
          child: AnimatedTextKit(
            animatedTexts: [
              RotateAnimatedText('AWESOME'),
              RotateAnimatedText('OPTIMISTIC'),
              RotateAnimatedText('DIFFERENT'),
            ],
            isRepeatingAnimation: true,
            onTap: () {
              print("Tap Event");
            },
          ),
        ),
      ],
    );
  }
}
