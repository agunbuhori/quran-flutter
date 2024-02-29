import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:quran/src/features/home/home_page.dart';
import 'package:quran/src/settings/settings_controller.dart';
import 'package:quran/src/settings/settings_service.dart';

class QuranApp extends StatefulWidget {
  const QuranApp({super.key});

  @override
  State<QuranApp> createState() => _QuranAppState();
}

class _QuranAppState extends State<QuranApp> {
  final SettingsController settingsController =
      SettingsController(SettingsService());

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      darkTheme: ThemeData(brightness: Brightness.dark),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 106, 55, 5)),
        tabBarTheme: const TabBarTheme(indicatorColor: Colors.limeAccent),
        useMaterial3: true,
      ),
      themeMode: ThemeMode.dark,
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
