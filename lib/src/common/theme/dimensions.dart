import 'package:flutter/material.dart';

class Dimensions {
  static double getStandardPadding(BuildContext context) {
    return MediaQuery.of(context).size.width < 375 ? 8 : 16;
  }
}
