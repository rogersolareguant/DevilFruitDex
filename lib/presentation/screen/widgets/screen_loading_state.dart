import 'package:flutter/material.dart';

class ScreenLoadingState extends StatelessWidget {
  const ScreenLoadingState({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
