import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  final String text;
  final Color color;
  final String? imageAssetPath;
  final VoidCallback onTapCallBack;

  const CardWidget({
    required this.text,
    required this.color,
    this.imageAssetPath,
    required this.onTapCallBack,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        clipBehavior: Clip.hardEdge,
        color: color,
        shadowColor: Colors.black,
        child: InkWell(
          splashColor: Colors.blue.withAlpha(30),
          onTap: onTapCallBack,
          child: SizedBox(
            width: 300,
            height: 100,

            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (imageAssetPath != null)
                    Image.asset(
                      imageAssetPath!,
                      height: 40,
                      width: 40,
                      fit: BoxFit.contain,
                    ),
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
