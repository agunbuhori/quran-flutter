import 'package:flutter/material.dart';

class CustomModal extends StatelessWidget {
  final Widget child;

  const CustomModal({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Material(color: Colors.transparent, child: child),
    );
  }
}
