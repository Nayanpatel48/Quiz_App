import 'package:flutter/material.dart';
import 'package:repradar/Home/view/widgets/card_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home Page')),
      body: Column(
        children: [
          CardWidget(text: 'Python', color: Colors.blueAccent),
          const SizedBox(height: 5),
          CardWidget(text: 'JavaScript', color: Colors.lightGreenAccent),
          const SizedBox(height: 5),
          CardWidget(text: 'Dart', color: Colors.orange),
        ],
      ),
    );
  }
}
