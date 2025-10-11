import 'package:flutter/material.dart';

class DartPage extends StatefulWidget {
  // constructor
  const DartPage({super.key});

  @override
  State<DartPage> createState() => _DartPageState();
}

class _DartPageState extends State<DartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: const Text('Dart Test')));
  }
}
