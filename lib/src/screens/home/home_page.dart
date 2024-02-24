import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Widget> tabs = [
    const Tab(text: "Surat"),
    const Tab(text: "Juz"),
    const Tab(text: "Penanda"),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: tabs.length,
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Quran Tadabbur"),
            bottom: TabBar(tabs: tabs),
          ),
          body: const TabBarView(children: [
            Center(child: Text("Hello")),
            Center(child: Text("Hello")),
            Center(child: Text("Hello")),
          ]),
        ));
  }
}
