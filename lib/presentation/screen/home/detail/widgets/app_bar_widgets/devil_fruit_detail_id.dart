import 'package:devilfruitdex/domain/model/devil_fruit.dart';
import 'package:flutter/material.dart';

class DevilFruitDetailId extends StatelessWidget {
  const DevilFruitDetailId({
    super.key,
    required this.devilFruit,
  });

  final DevilFruit devilFruit;

  @override
  Widget build(BuildContext context) {
    return Text('#${devilFruit.id}',
        style: Theme.of(context).textTheme.titleSmall);
  }
}
