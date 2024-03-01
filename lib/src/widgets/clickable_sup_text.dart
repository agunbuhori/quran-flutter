import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class ClickableSupText extends StatelessWidget {
  final String text;
  final Function(int)? onTap;

  const ClickableSupText({
    super.key,
    required this.text,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Text(text);
  }
}
