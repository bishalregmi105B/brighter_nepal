import 'package:flutter/material.dart';

class CardItem extends StatelessWidget {
  final String title;
  final String description;

  const CardItem({
    required this.title,
    required this.description,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: ListTile(
        title: Text(title),
        subtitle: Text(description),
      ),
    );
  }
}
