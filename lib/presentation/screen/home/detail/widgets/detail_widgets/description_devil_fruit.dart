import 'package:devilfruitdex/domain/model/devil_fruit.dart';
import 'package:devilfruitdex/presentation/extensions/extensions.dart';
import 'package:flutter/material.dart';

class DescriptionDevilFruit extends StatelessWidget {
  const DescriptionDevilFruit({
    super.key,
    required this.devilFruit,
  });

  final DevilFruit devilFruit;

  @override
  Widget build(BuildContext context) {
    return Text(
      devilFruit.description.capitalize(),
      style: Theme.of(context).textTheme.bodyMedium,
      //style: Theme.of(context).textTheme.bodyLarge,
      textAlign: TextAlign.justify,
      softWrap: true,
      //overflow: TextOverflow.visible,
    );
  }
}
