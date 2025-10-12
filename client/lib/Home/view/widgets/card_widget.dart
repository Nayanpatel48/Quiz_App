import 'package:flutter/material.dart';
import 'package:repradar/Python/view/python_page.dart';

class CardWidget extends StatelessWidget {
  // Taking custom text from tha main page
  final String text;
  final Color color;
  final String? imageAssetPath;
  final VoidCallback onTapCallBack;

  //constructor for initializing the properties of the widget
  const CardWidget({
    required this.text,
    required this.color,
    this.imageAssetPath, //optional
    required this.onTapCallBack,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        // clipBehavior is necessary because, without it, the InkWell's animation
        // will extend beyond the rounded edges of the [Card] (see https://github.com/flutter/flutter/issues/109776)
        // This comes with a small performance cost, and you should not set [clipBehavior]
        // unless you need it.
        clipBehavior: Clip.hardEdge,

        //----------------
        color: color,

        //-------------
        shadowColor: Colors.black,

        //-----------
        child: InkWell(
          //--------------
          splashColor: Colors.blue.withAlpha(30),

          //--------------
          onTap: onTapCallBack,

          //----------
          child: SizedBox(
            width: 300,
            height: 100,

            //---------------
            child: Padding(
              padding: EdgeInsets.all(8.0),

              //-----------------
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,

                //---------------
                children: [
                  //-----------
                  if (imageAssetPath != null)
                    Image.asset(
                      imageAssetPath!,
                      height: 40,
                      width: 40,
                      fit: BoxFit.contain,
                    ),

                  //-------------
                  if (imageAssetPath != null) const SizedBox(height: 8),
                  Text(
                    text,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
