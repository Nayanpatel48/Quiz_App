import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  //constructor of the widget
  const LoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}
