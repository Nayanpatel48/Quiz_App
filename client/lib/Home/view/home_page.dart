import 'package:flutter/material.dart';
import 'package:repradar/Dart/view/dart_page.dart';
import 'package:repradar/Home/view/widgets/card_widget.dart';
import 'package:repradar/Js/view/js_page.dart';
import 'package:repradar/Python/view/python_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void _handleCardTap(BuildContext context, String subjectName) {
    switch (subjectName) {
      case 'Python':
        //Navigate to the python screen
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const PythonPage()),
        );
        break;
      case 'JavaScript':
        //Navigate to the python screen
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const JsPage()),
        );
        break;
      case 'Dart':
        //Navigate to the python screen
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const DartPage()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home Page')),
      body: Column(
        children: [
          CardWidget(
            text: 'Python',
            color: Colors.blue,
            imageAssetPath:
                '/home/nayan/github/Gamified-Coding-App/client/lib/assets/images/python_logo.png',
            onTapCallBack: () => _handleCardTap(context, 'Python'),
          ),
          const SizedBox(height: 5),
          CardWidget(
            text: 'JavaScript',
            color: Colors.lightGreenAccent,
            imageAssetPath:
                '/home/nayan/github/Gamified-Coding-App/client/lib/assets/images/javaScript_logo.png',
            onTapCallBack: () => _handleCardTap(context, 'JavaScript'),
          ),
          const SizedBox(height: 5),
          CardWidget(
            text: 'Dart',
            color: Colors.orange,
            imageAssetPath:
                '/home/nayan/github/Gamified-Coding-App/client/lib/assets/images/dart_logo.png',
            onTapCallBack: () => _handleCardTap(context, 'Dart'),
          ),
        ],
      ),
    );
  }
}
