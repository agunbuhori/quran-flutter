class LocalAssets {
  static String ayahFrame = "assets/images/quran/ayah_frame.png";
  static String surahFrame = "assets/images/quran/frame.png";

  static String getQuranPage(int number) {
    return "assets/images/quran/tilawah_1/${number.toString()}.png";
  }
}
