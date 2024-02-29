import 'package:flutter/material.dart';

class MurotalPage extends StatefulWidget {
  const MurotalPage({super.key});

  @override
  State<MurotalPage> createState() => _MurotalPageState();
}

class _MurotalPageState extends State<MurotalPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Murotal"),
      ),
    );
  }
}
