import 'package:flutter/material.dart';

class NumberFrame extends StatelessWidget {
  final int number;
  const NumberFrame({super.key, required this.number});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 40,
        height: 40,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/quran/frame.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
            child: Text(
          number.toString(),
          style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
        )));
  }
}
