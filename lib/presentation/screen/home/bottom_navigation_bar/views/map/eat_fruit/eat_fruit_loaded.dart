import 'package:carousel_slider/carousel_slider.dart';
import 'package:devilfruitdex/domain/model/devil_fruit.dart';
import 'package:devilfruitdex/presentation/screen/home/cubit/devil_fruit_cubit.dart';
import 'package:devilfruitdex/presentation/screen/home/detail/widgets/app_bar_widgets/devil_fruit_detail_id.dart';
import 'package:devilfruitdex/presentation/screen/home/detail/widgets/app_bar_widgets/go_back_button.dart';
import 'package:devilfruitdex/presentation/screen/home/detail/widgets/app_bar_widgets/title_detail_screen.dart';
import 'package:devilfruitdex/presentation/screen/home/detail/widgets/detail_widgets/devil_fruit_type.dart';
import 'package:devilfruitdex/presentation/screen/home/detail/widgets/detail_widgets/image_positioned_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EatFruitLoaded extends StatelessWidget {
  final DevilFruit devilFruit;

  const EatFruitLoaded({
    super.key,
    required this.devilFruit,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DevilFruitCubit, DevilFruitState>(
      builder: (context, state) {
        return Scaffold(
          body: Stack(children: [
            AppBar(
                leading: const GoBackButton(),
                title: TitleDetailScreen(devilFruit: devilFruit),
                actions: [
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: DevilFruitDetailId(devilFruit: devilFruit)),
                ]),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 110, 0, 0),
              child: Container(
                  alignment: Alignment.topCenter,
                  child: FilledButton(
                      onPressed: () {
                        context.read<DevilFruitCubit>().updateEating(true);
                      },
                      style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all(
                              Theme.of(context)
                                  .colorScheme
                                  .onPrimaryFixedVariant)),
                      child: Text(AppLocalizations.of(context)!.eat,
                          style: Theme.of(context).textTheme.bodyLarge))),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 220, 0, 0),
              child: Container(
                alignment: Alignment.center,
                height: 1000,
                width: 410,
                color: Theme.of(context).dialogBackgroundColor,
                child: SafeArea(
                  child: ListView(
                    children: [
                      Stack(alignment: Alignment.center, children: [
                        ImagePositionedEat(devilFruit: devilFruit),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(90, 0, 0, 0),
                          child: Visibility(
                            visible: state.isEating,
                            child: Container(
                                width: 70,
                                height: 70,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color:
                                      Theme.of(context).dialogBackgroundColor,
                                )),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(100, 70, 0, 0),
                          child: Visibility(
                            visible: state.isEating,
                            child: Container(
                                width: 70,
                                height: 70,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color:
                                      Theme.of(context).dialogBackgroundColor,
                                )),
                          ),
                        )
                      ]),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 30, 0, 10),
                          child: Visibility(
                              visible: state.isEating,
                              child: DevilFruitType(devilFruit: devilFruit)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                        child: Visibility(
                            visible: state.isEating,
                            child: Text(
                              '${AppLocalizations.of(context)!.justEat} ${devilFruit.romanName}${AppLocalizations.of(context)!.getPower} ${devilFruit.name}${AppLocalizations.of(context)!.weakWater}',
                              style: Theme.of(context).textTheme.bodyMedium,
                              textAlign: TextAlign.justify,
                              softWrap: true,
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 50, 20, 0),
                        child: Visibility(
                            visible: state.isEating,
                            child: Text(
                              AppLocalizations.of(context)!.gallery,
                              style: Theme.of(context).textTheme.displayLarge,
                              textAlign: TextAlign.center,
                              softWrap: true,
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 80),
                        child: Visibility(
                          visible: state.isEating,
                          child: Container(
                              padding: const EdgeInsets.all(10),
                              child: DevilFruitGallery(type: devilFruit.type)),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ]),
        );
      },
    );
  }
}

class DevilFruitGallery extends StatelessWidget {
  final String type;

  const DevilFruitGallery({super.key, required this.type});

  static final Map<String, List<String>> imageMap = {
    'Paramecia': [
      'assets/images/paramecia-gif.gif',
      'assets/images/paramecia1.webp',
      'assets/images/paramecia2.jpeg',
      'assets/images/paramecia3.jpg',
      'assets/images/paramecia4.avif',
      'assets/images/paramecia5.avif',
    ],
    'Logia': [
      'assets/images/logia-gif.gif',
      'assets/images/logia1.webp',
      'assets/images/logia2.webp',
      'assets/images/logia3.webp',
      'assets/images/logia4.avif',
      'assets/images/logia5.avif',
    ],
    'Zoan': [
      'assets/images/zoan-gif.gif',
      'assets/images/zoan1.webp',
      'assets/images/zoan2.webp',
      'assets/images/zoan3.jpg',
      'assets/images/zoan4.jpg',
      'assets/images/zoan5.webp',
    ],
    'Smile': [
      'assets/images/smile0.webp',
      'assets/images/smile1.webp',
      'assets/images/smile2.png',
      'assets/images/smile3.gif',
      'assets/images/smile4.jpg',
      'assets/images/smile5.webp',
    ],
  };

  List<String> _getImagesByType(String type) {
    return imageMap[type] ?? imageMap['Zoan']!;
  }

  @override
  Widget build(BuildContext context) {
    List<String> images = _getImagesByType(type);

    return CarouselSlider(
        options: CarouselOptions(
          height: 250,
          autoPlay: true,
          enlargeCenterPage: true,
          viewportFraction: 0.8,
        ),
        items: images
            .map((url) => ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(url, fit: BoxFit.cover),
                ))
            .toList());
  }
}
