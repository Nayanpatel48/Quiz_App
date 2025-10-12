import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  // Taking custom text from tha main page
  final String text;
  final Color color;

  //constructor for initializing the properties of the widget
  const CardWidget({required this.text, required this.color, super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        // clipBehavior is necessary because, without it, the InkWell's animation
        // will extend beyond the rounded edges of the [Card] (see https://github.com/flutter/flutter/issues/109776)
        // This comes with a small performance cost, and you should not set [clipBehavior]
        // unless you need it.
        clipBehavior: Clip.hardEdge,
        color: color,
        shadowColor: Colors.black,
        child: InkWell(
          splashColor: Colors.blue.withAlpha(30),
          onTap: () {},
          child: SizedBox(
            width: 300,
            height: 100,
            child: Text(text, textAlign: TextAlign.center),
          ),
        ),
      ),
    );
  }
}
