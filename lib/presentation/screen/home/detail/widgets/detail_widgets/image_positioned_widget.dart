import 'package:devilfruitdex/domain/model/devil_fruit.dart';
import 'package:flutter/material.dart';

class ImagePositioned extends StatelessWidget {
  final DevilFruit devilFruit;

  const ImagePositioned({
    super.key,
    required this.devilFruit,
  });

  @override
  Widget build(BuildContext context) {
    if (!(devilFruit.filename.contains('.png') ||
        devilFruit.filename.contains('.jpg'))) {
      return Padding(
        padding: const EdgeInsets.only(top: 70),
        child: Container(
          alignment: Alignment.topCenter,
          child: Image.asset(
            '/Users/rogersolareguant/Desktop/Flutter/devil_fruitdex/assets/images/incognit-fruit.png',
            scale: 2,
            height: 180,
            width: 180,
          ),
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.only(top: 70),
        child: Container(
          alignment: Alignment.topCenter,
          child: Image.network(
            devilFruit.filename,
            fit: BoxFit.contain,
            height: 180,
            width: 180,
          ),
        ),
      );
    }
  }
}
