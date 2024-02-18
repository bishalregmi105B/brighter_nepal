import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shimmer/shimmer.dart';

class LoadingAnimation extends StatelessWidget {
  const LoadingAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    return LoadingAnimationWidget.flickr(
      leftDotColor: const Color.fromARGB(255, 213, 213, 240),
      rightDotColor: const Color.fromARGB(255, 91, 125, 236),
      size: 40,
    );
  }
}

class SkeletonLoading extends StatelessWidget {
  const SkeletonLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 150.0,
            width: double.infinity,
            color: Colors.white,
          ),
          const SizedBox(height: 10.0),
          Container(
            height: 20.0,
            width: 200.0,
            color: Colors.white,
          ),
          const SizedBox(height: 10.0),
          Container(
            height: 20.0,
            width: 150.0,
            color: Colors.white,
          ),
          const SizedBox(height: 10.0),

          Container(
            height: 150.0,
            width: double.infinity,
            color: Colors.white,
          ),
          const SizedBox(height: 10.0),
          Container(
            height: 20.0,
            width: 200.0,
            color: Colors.white,
          ),
          const SizedBox(height: 10.0),
          Container(
            height: 20.0,
            width: 150.0,
            color: Colors.white,
          ),
          const SizedBox(height: 10.0),

          Container(
            height: 150.0,
            width: double.infinity,
            color: Colors.white,
          ),
          const SizedBox(height: 10.0),
          Container(
            height: 20.0,
            width: 200.0,
            color: Colors.white,
          ),
          const SizedBox(height: 10.0),
          Container(
            height: 20.0,
            width: 150.0,
            color: Colors.white,
          ),
          const SizedBox(height: 10.0),
          // Add more skeleton loading containers as needed
        ],
      ),
    );
  }
}

class Card_Skeletan extends StatelessWidget {
  const Card_Skeletan({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 20.0,
            width: 100.0,
            color: Colors.white,
          ),
          const SizedBox(height: 10.0),
          Container(
            height: 100.0,
            width: double.infinity,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
