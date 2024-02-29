import 'package:flutter/material.dart';
import 'package:quran/src/features/murotal/murotal_page.dart';
import 'package:quran/src/features/quran/quran_page.dart';
import 'package:quran/src/features/settings/settings_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    const List<Widget> widgetOptions = <Widget>[
      QuranPage(),
      MurotalPage(),
      SettingsPage()
    ];
    return DefaultTabController(
        length: widgetOptions.length,
        child: Scaffold(
          body: widgetOptions.elementAt(index),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: index,
            onTap: (newIndex) {
              setState(() {
                index = newIndex;
              });
            },
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.menu_book), label: 'Al-Quran'),
              BottomNavigationBarItem(icon: Icon(Icons.mic), label: 'Murotal'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings), label: 'Pengaturan'),
            ],
          ),
        ));
  }
}
