import 'package:devilfruitdex/domain/model/devil_fruit.dart';
import 'package:devilfruitdex/presentation/extensions/extensions.dart';
import 'package:flutter/material.dart';

class TitleDetailScreen extends StatelessWidget {
  const TitleDetailScreen({
    super.key,
    required this.devilFruit,
  });

  final DevilFruit devilFruit;

  @override
  Widget build(BuildContext context) {
    return Text(
      devilFruit.romanName.shortName(),
      style: Theme.of(context).textTheme.titleMedium,
      softWrap: true,
      textAlign: TextAlign.center,
    );
  }
}
