import 'package:devilfruitdex/domain/model/devil_fruit.dart';
import 'package:devilfruitdex/presentation/screen/home/bottom_navigation_bar/widgets/image_widgets/image_widgets.dart';
import 'package:flutter/material.dart';

class NoImageFruit extends StatelessWidget {
  final List<DevilFruit> state;
  final int index;

  const NoImageFruit({super.key, required this.state, required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          border: Border.all(color: Theme.of(context).cardColor, width: 3),
          borderRadius: BorderRadius.circular(10)),
      height: 100,
      width: 100,
      child: Column(
        children: [
          ImageIdText(id: state[index].id),
          Expanded(
            child: Image.asset(
                'assets/images/incognit-fruit.png'),
          ),
          ImageNameText(romanName: state[index].romanName),
        ],
      ),
    );
  }
}
