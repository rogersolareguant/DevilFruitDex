import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class GoBackButton extends StatelessWidget {
  const GoBackButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          context.go('/home');
        },
        icon: Icon(Icons.arrow_back_rounded,
            color: Theme.of(context).primaryIconTheme.color));
  }
}
