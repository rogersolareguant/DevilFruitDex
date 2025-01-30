import 'package:devilfruitdex/presentation/extensions/extensions.dart';
import 'package:flutter/material.dart';

class ImageIdText extends StatelessWidget {
  final int id;

  const ImageIdText({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Text(
      '#$id',
      textAlign: TextAlign.right,
      style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 0.7),
    );
  }
}

class ImageNameText extends StatelessWidget {
  final String romanName;

  const ImageNameText({super.key, required this.romanName});

  @override
  Widget build(BuildContext context) {
    return Text(
      romanName.shortName(),
      textAlign: TextAlign.center,
      style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 0.65),
    );
  }
}
