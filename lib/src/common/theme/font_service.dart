import 'package:get/get.dart';

class FontSizeService extends GetxService {
  final RxDouble _arabicFontSize =
      16.0.obs; // Initial font size, you can set it to any default value

  double get arabicFontSize => _arabicFontSize.value;

  set fontSize(double value) => _arabicFontSize.value = value;
}
