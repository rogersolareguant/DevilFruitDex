import 'package:devilfruitdex/domain/model/devil_fruit.dart';
import 'package:flutter/material.dart';

class NameDevilFruit extends StatelessWidget {
  const NameDevilFruit({
    super.key,
    required this.devilFruit,
  });

  final DevilFruit devilFruit;

  @override
  Widget build(BuildContext context) {
    return Text(devilFruit.name,
        style: Theme.of(context).textTheme.bodyMedium,
        textAlign: TextAlign.center,
        softWrap: true,
        overflow: TextOverflow.visible);
  }
}
