import 'package:flutter/material.dart';

class ClickableSupText extends StatelessWidget {
  final String text;
  final Function(int) onFootnotePressed;

  const ClickableSupText(
      {super.key, required this.text, required this.onFootnotePressed});

  @override
  Widget build(BuildContext context) {
    List<InlineSpan> inlineSpans = [];
    RegExp exp = RegExp(r"<sup\sfoot_note=(\d+)>(\d+)</sup>");
    int start = 0;

    for (RegExpMatch match in exp.allMatches(text)) {
      // Add text before the sup tag
      inlineSpans.add(TextSpan(text: text.substring(start, match.start)));

      // Extract footnote id and sup text
      int footnoteId = int.parse(match.group(1)!);
      String supText = match.group(2)!;

      // Create clickable sup widget with sup number at top
      inlineSpans.add(WidgetSpan(
        alignment: PlaceholderAlignment.top,
        baseline: TextBaseline.alphabetic,
        child: GestureDetector(
          child: Text(
            " [$supText]",
            textAlign: TextAlign.justify,
            style: const TextStyle(
              fontSize: 10.0, // Adjust font size as needed
              color: Colors.blue, // Change color as needed
            ),
          ),
          onTap: () {
            onFootnotePressed(footnoteId);
          },
        ),
      ));

      start = match.end;
    }

    // Add remaining text
    inlineSpans.add(TextSpan(text: text.substring(start)));

    return RichText(
      textAlign: TextAlign.justify,
      textDirection: TextDirection.ltr,
      text: TextSpan(
        children: inlineSpans,
      ),
    );
  }
}
