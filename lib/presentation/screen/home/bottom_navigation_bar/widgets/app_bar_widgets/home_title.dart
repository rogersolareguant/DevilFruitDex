import 'package:flutter/material.dart';

class HomeTitle extends StatelessWidget {
  const HomeTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Text('Devildex', style: Theme.of(context).textTheme.titleLarge);
  }
}
