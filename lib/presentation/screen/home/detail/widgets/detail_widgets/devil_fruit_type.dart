import 'package:devilfruitdex/domain/model/devil_fruit.dart';
import 'package:flutter/material.dart';

class DevilFruitType extends StatelessWidget {
  const DevilFruitType({
    super.key,
    required this.devilFruit,
  });

  final DevilFruit devilFruit;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: devilFruit.type == 'Paramecia'
              ? colors.error
              : devilFruit.type == 'Logia'
                  ? colors.primary
                  : devilFruit.type == 'Zoan' ||
                          devilFruit.type == 'Zoan Antique' ||
                          devilFruit.type == 'Zoan Mythique'
                      ? colors.secondary
                      : colors.tertiary,
          borderRadius: BorderRadius.circular(20)),
      child:
          Text(devilFruit.type, style: Theme.of(context).textTheme.bodyLarge),
    );
  }
}
