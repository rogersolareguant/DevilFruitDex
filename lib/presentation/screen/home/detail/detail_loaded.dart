import 'package:devilfruitdex/domain/model/devil_fruit.dart';
import 'package:devilfruitdex/presentation/screen/home/cubit/devil_fruit_cubit.dart';
import 'package:devilfruitdex/presentation/screen/home/detail/widgets/app_bar_widgets/devil_fruit_detail_id.dart';
import 'package:devilfruitdex/presentation/screen/home/detail/widgets/app_bar_widgets/go_back_button.dart';
import 'package:devilfruitdex/presentation/screen/home/detail/widgets/app_bar_widgets/title_detail_screen.dart';
import 'package:devilfruitdex/presentation/screen/home/detail/widgets/detail_widgets/const_detail_widgets.dart';
import 'package:devilfruitdex/presentation/screen/home/detail/widgets/detail_widgets/description_devil_fruit.dart';
import 'package:devilfruitdex/presentation/screen/home/detail/widgets/detail_widgets/devil_fruit_type.dart';
import 'package:devilfruitdex/presentation/screen/home/detail/widgets/detail_widgets/full_name_devil_fruit.dart';
import 'package:devilfruitdex/presentation/screen/home/detail/widgets/detail_widgets/image_positioned_widget.dart';
import 'package:devilfruitdex/presentation/screen/home/detail/widgets/detail_widgets/name_devil_fruit.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailLoaded extends StatelessWidget {
  final DevilFruit devilFruit;

  const DetailLoaded({
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
              padding: const EdgeInsets.fromLTRB(0, 220, 0, 0),
              child: Container(
                alignment: Alignment.center,
                height: 1000,
                width: 410,
                color: Theme.of(context).dialogBackgroundColor,
                child: SafeArea(
                  child: ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              icon: Icon(
                                state.favourtieDevilFruitList.contains(devilFruit)
                                    ? Icons.favorite
                                    : Icons.favorite_outline,
                              ),
                              onPressed: () {
                                context
                                    .read<DevilFruitCubit>()
                                    .favouriteFruits(devilFruit.id);
                              },
                            )
                          ],
                        ),
                      ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child: DevilFruitType(devilFruit: devilFruit),
                        ),
                      ),
                      const Center(
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
                          child: AboutText(),
                        ),
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Flexible(
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  children: [
                                    FullNameDevilFruit(devilFruit: devilFruit),
                                    const SizedBox(height: 10),
                                    const FullNameText(),
                                  ],
                                ),
                              ),
                            ),
                            const SeparatorDetail(),
                            Flexible(
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  children: [
                                    NameDevilFruit(devilFruit: devilFruit),
                                    const SizedBox(height: 10),
                                    const NameText(),
                                  ],
                                ),
                              ),
                            ),
                          ]),
                      const Padding(
                        padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
                        child: DescriptionText(),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                        child: DescriptionDevilFruit(devilFruit: devilFruit),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            ImagePositioned(devilFruit: devilFruit)
          ]),
        );
      },
    );
  }
}
