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
    return IgnorePointer(
      ignoring: true,
      child: Container(
        alignment: Alignment.centerLeft,
        child: RichText(
          text: TextSpan(
            children: _buildTextSpans(context),
          ),
          textAlign: TextAlign.justify,
        ),
      ),
    );
  }

  List<TextSpan> _buildTextSpans(BuildContext context) {
    List<TextSpan> spans = [];

    RegExp regex = RegExp(r'<sup foot_note=(\d+)>(\d+)</sup>');

    List<RegExpMatch> matches = regex.allMatches(text).toList();

    int currentIndex = 0;
    for (RegExpMatch match in matches) {
      spans.add(TextSpan(text: text.substring(currentIndex, match.start)));
      spans.add(
        TextSpan(
          text: " [${match.group(2)}]",
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              if (onTap != null) {
                onTap!(int.parse(match.group(2)!));
              }
            },
          style: const TextStyle(
            color: Colors.blue,
          ),
        ),
      );
      currentIndex = match.end;
    }

    spans.add(TextSpan(text: text.substring(currentIndex)));

    return spans;
  }
}
