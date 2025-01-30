import 'package:devilfruitdex/domain/model/devil_fruit.dart';
import 'package:devilfruitdex/presentation/screen/home/cubit/devil_fruit_cubit.dart';
import 'package:devilfruitdex/presentation/screen/home/bottom_navigation_bar/widgets/app_bar_widgets/home_filters_button.dart';
import 'package:devilfruitdex/presentation/screen/home/bottom_navigation_bar/widgets/app_bar_widgets/home_luffy_hat.dart';
import 'package:devilfruitdex/presentation/screen/home/bottom_navigation_bar/widgets/app_bar_widgets/home_search_bar.dart';
import 'package:devilfruitdex/presentation/screen/home/bottom_navigation_bar/widgets/app_bar_widgets/home_title.dart';
import 'package:devilfruitdex/presentation/screen/home/bottom_navigation_bar/widgets/image_widgets/image_fruit.dart';
import 'package:devilfruitdex/presentation/screen/home/bottom_navigation_bar/widgets/image_widgets/no_image_fruit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FavView extends StatelessWidget {
  final List<DevilFruit> favoriteDevilFruits;


  const FavView({
    super.key,
    this.favoriteDevilFruits = const [],
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DevilFruitCubit, DevilFruitState>(
      builder: (context, state) {
        final favoriteDevilFruits = state.filteredAndSortedFavourtieDevilFruitList;

        return Scaffold(
          appBar: AppBar(
            leading: const HomeLuffyHat(),
            title: const HomeTitle(),
            centerTitle: false,
            bottom: const PreferredSize(
                preferredSize: Size.fromHeight(55),
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: FavHomeSearchBar(),
                )),
            actions: [
              const FavHomeTypeFilterButton(),
              const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: FavHomeSortButton()),
              InkWell(
                onTap: () {
                  FirebaseAuth.instance.signOut();
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
              child: favoriteDevilFruits.isEmpty
                  ? Center(
                      child: Text(AppLocalizations.of(context)!.noFav,
                          style: Theme.of(context).textTheme.bodyMedium))
                  : GridView.builder(
                      itemCount: favoriteDevilFruits.length,
                      itemBuilder: (context, index) {
                        if (!(favoriteDevilFruits[index]
                                .filename
                                .contains('.png') ||
                            favoriteDevilFruits[index]
                                .filename
                                .contains('.jpg'))) {
                          return InkWell(
                            onTap: () {
                              context.go(
                                  '/home/detail/${favoriteDevilFruits[index].id}');
                            },
                            child: NoImageFruit(
                                state: favoriteDevilFruits, index: index),
                          );
                        } else {
                          return InkWell(
                            onTap: () {
                              context.go(
                                  '/home/detail/${favoriteDevilFruits[index].id}');
                            },
                            child: ImageFruit(
                                state: favoriteDevilFruits, index: index),
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
            ),
          ),
        );
      },
    );
  }
}
