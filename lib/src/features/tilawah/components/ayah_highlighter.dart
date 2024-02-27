import 'package:flutter/material.dart';

class AyahHighlighter extends StatelessWidget {
  const AyahHighlighter({super.key});

  double calculateHeight(
      double givenWidth, double originalWidth, double originalHeight) {
    return (givenWidth * originalHeight) / originalWidth;
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: screenWidth,
      height: calculateHeight(screenWidth, 1024, 1657) /
          15.3, // Set width to screen width
      decoration: BoxDecoration(
        color:
            Colors.greenAccent.withOpacity(0.1), // Blue with 50% transparency
        borderRadius:
            BorderRadius.circular(5.0), // Adjust as per your requirement
      ),
    );
  }
}
