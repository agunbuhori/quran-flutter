import 'package:flutter/material.dart';

class CustomModal extends StatelessWidget {
  final Widget child;
  const CustomModal({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Stack(
          children: [
            // Your main content here
            // Floating container at the bottom
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: child,
            ),
          ],
        ),
      ),
    );
  }
}
