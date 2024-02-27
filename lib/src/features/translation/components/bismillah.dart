import 'package:flutter/material.dart';

class Bismillah extends StatelessWidget {
  const Bismillah({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 20, bottom: 10),
      child: const Center(
          child: Text('6',
              style: TextStyle(fontSize: 16, fontFamily: 'Bismillah'))),
    );
  }
}
