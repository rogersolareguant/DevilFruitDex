import 'package:devilfruitdex/domain/model/devil_fruit.dart';
import 'package:flutter/material.dart';

class FullNameDevilFruit extends StatelessWidget {
  const FullNameDevilFruit({
    super.key,
    required this.devilFruit,
  });

  final DevilFruit devilFruit;

  @override
  Widget build(BuildContext context) {
    return Text(
      devilFruit.romanName,
      style: Theme.of(context).textTheme.bodyMedium,
      softWrap: true,
      overflow: TextOverflow.visible,
      textAlign: TextAlign.center,
    );
  }
}
