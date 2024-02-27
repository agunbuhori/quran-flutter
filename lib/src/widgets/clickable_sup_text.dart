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
    return Container(
      alignment: Alignment.centerLeft,
      child: SelectableText.rich(
        TextSpan(
          children: _buildTextSpans(),
        ),
        textAlign: TextAlign.justify,
      ),
    );
  }

  List<InlineSpan> _buildTextSpans() {
    List<InlineSpan> spans = [];

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
