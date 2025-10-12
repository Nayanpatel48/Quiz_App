import 'package:flutter/material.dart';

class PythonPage extends StatefulWidget {
  const PythonPage({super.key});

  @override
  State<PythonPage> createState() => _PythonPageState();
}

class _PythonPageState extends State<PythonPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: const Text('Python Test')));
  }
}
