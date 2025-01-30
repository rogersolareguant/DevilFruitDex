import 'package:flutter/material.dart';

class HomeLuffyHat extends StatelessWidget {
  const HomeLuffyHat({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Image.asset(
          '/Users/rogersolareguant/Desktop/Flutter/devil_fruitdex/assets/images/farmer-hat.png'),
    );
  }
}
