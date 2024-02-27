import 'package:flutter/material.dart';

class Bismillah extends StatelessWidget {
  const Bismillah({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Center(
          child: Text('﷽',
              style: TextStyle(fontSize: 24, fontFamily: 'Bismillah'))),
    );
  }
}
