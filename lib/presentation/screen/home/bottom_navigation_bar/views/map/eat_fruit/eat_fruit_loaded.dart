import 'package:devilfruitdex/domain/model/devil_fruit.dart';
import 'package:devilfruitdex/presentation/screen/home/cubit/devil_fruit_cubit.dart';
import 'package:devilfruitdex/presentation/screen/home/detail/widgets/app_bar_widgets/devil_fruit_detail_id.dart';
import 'package:devilfruitdex/presentation/screen/home/detail/widgets/app_bar_widgets/go_back_button.dart';
import 'package:devilfruitdex/presentation/screen/home/detail/widgets/app_bar_widgets/title_detail_screen.dart';
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
                        ImagePositioned(devilFruit: devilFruit),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(90, 50, 0, 0),
                          child: Visibility(
                            visible: state.isEating,
                            child: Container(
                                width: 70,
                                height: 70,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                )),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(100, 120, 0, 0),
                          child: Visibility(
                            visible: state.isEating,
                            child: Container(
                                width: 70,
                                height: 70,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                )),
                          ),
                        )
                      ]),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                        child: Visibility(
                            visible: state.isEating,
                            child: Text(
                              '${AppLocalizations.of(context)!.justEat} ${devilFruit.romanName}${AppLocalizations.of(context)!.getPower} ${devilFruit.name}${AppLocalizations.of(context)!.weakWater}',
                              style: Theme.of(context).textTheme.bodyMedium,
                              textAlign: TextAlign.justify,
                              softWrap: true,
                            )),
                      ),
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
