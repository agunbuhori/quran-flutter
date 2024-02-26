import 'package:flutter/material.dart';

class ListDetail extends StatelessWidget {
  final String title;
  final String subtitle;

  const ListDetail({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(subtitle)
        ],
      ),
    );
  }
}
