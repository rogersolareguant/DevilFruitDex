import 'package:devilfruitdex/domain/model/devil_fruit.dart';
import 'package:devilfruitdex/presentation/screen/home/cubit/devil_fruit_cubit.dart';
import 'package:devilfruitdex/presentation/screen/home/bottom_navigation_bar/widgets/app_bar_widgets/home_filters_button.dart';
import 'package:devilfruitdex/presentation/screen/home/bottom_navigation_bar/widgets/app_bar_widgets/home_luffy_hat.dart';
import 'package:devilfruitdex/presentation/screen/home/bottom_navigation_bar/widgets/app_bar_widgets/home_search_bar.dart';
import 'package:devilfruitdex/presentation/screen/home/bottom_navigation_bar/widgets/app_bar_widgets/home_title.dart';
import 'package:devilfruitdex/presentation/screen/home/bottom_navigation_bar/widgets/image_widgets/image_fruit.dart';
import 'package:devilfruitdex/presentation/screen/home/bottom_navigation_bar/widgets/image_widgets/no_image_fruit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

class HomeView extends StatelessWidget {
  final List<DevilFruit> devilFruit;

  const HomeView({
    super.key,
    this.devilFruit = const [],
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DevilFruitCubit, DevilFruitState>(
        builder: (context, state) {
          final devilFruit = state.filteredAndSortedDevilFruitList;

          return Scaffold(
            appBar: AppBar(
              leading: const HomeLuffyHat(),
              title: const HomeTitle(),
              centerTitle: false,
              bottom: const PreferredSize(
                  preferredSize: Size.fromHeight(55),
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: HomeSearchBar(),
                  )),
              actions: [
                const HomeTypeFilterButton(),
                const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: HomeSortButton()),
                InkWell(
                  onTap: () {
                    context.read<DevilFruitCubit>().signOut();
                    context.go('/login');
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Icon(
                      Icons.exit_to_app,
                      color: Theme.of(context).primaryIconTheme.color,
                    ),
                  ),
                )
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).dialogBackgroundColor,
                    borderRadius: BorderRadius.circular(10)),
                child: devilFruit.isEmpty
                    ? Center(
                        child: Text(AppLocalizations.of(context)!.noFruit,
                            style: Theme.of(context).textTheme.bodyMedium))
                    : Stack(
                        children: [
                          Positioned.fill(
                            child: Lottie.asset(
                              'assets/animations/fire.json',
                              fit: BoxFit.cover,
                              repeat: true,
                            ),
                          ),
                          GridView.builder(
                            itemCount: devilFruit.length,
                            itemBuilder: (context, index) {
                              if (!(devilFruit[index]
                                      .filename
                                      .contains('.png') ||
                                  devilFruit[index]
                                      .filename
                                      .contains('.jpg'))) {
                                return InkWell(
                                  onTap: () {
                                    context.go(
                                        '/home/detail/${devilFruit[index].id}');
                                  },
                                  child: NoImageFruit(
                                      state: devilFruit, index: index),
                                );
                              } else {
                                return InkWell(
                                  onTap: () {
                                    context.go(
                                        '/home/detail/${devilFruit[index].id}');
                                  },
                                  child: ImageFruit(
                                      state: devilFruit, index: index),
                                );
                              }
                            },
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              mainAxisSpacing: 15,
                              crossAxisSpacing: 15,
                            ),
                            padding: const EdgeInsets.all(15),
                          ),
                        ],
                      ),
              ),
            ),
          );
        },
      
    );
  }
}
