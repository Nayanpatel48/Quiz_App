import 'package:flutter/material.dart';

class JsPage extends StatefulWidget {
  //constructor of this class
  const JsPage({super.key});

  @override
  State<JsPage> createState() => _JsPageState();
}

class _JsPageState extends State<JsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: const Text('JavaScript Test')));
  }
}
