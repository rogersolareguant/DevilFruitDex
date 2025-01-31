import 'package:devilfruitdex/domain/repository/devil_fruit_repository.dart';
import 'package:devilfruitdex/domain/repository/favourites_repository.dart';
import 'package:devilfruitdex/domain/repository/location_repository.dart';
import 'package:devilfruitdex/presentation/screen/home/cubit/devil_fruit_cubit.dart';
import 'package:devilfruitdex/presentation/screen/widgets/screen_error_state.dart';
import 'package:devilfruitdex/presentation/screen/home/bottom_navigation_bar/bottom_navigation_bar.dart';
import 'package:devilfruitdex/presentation/screen/widgets/screen_loading_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class HomeScreenProvider extends StatelessWidget {
  const HomeScreenProvider({super.key});

  @override
  Widget build(BuildContext context) {

    final User? currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser == null) {
      context.go('/login');
      return const ScreenLoadingState();
    }

    return BlocProvider(
      create: (context) => DevilFruitCubit(
          repository: context.read<DevilFruitRepository>(),
          favRepository: context.read<FavouritesRepository>(),
          locationRepository: context.read<LocationRepository>(),
          uid: currentUser.uid),
      child: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<DevilFruitCubit, DevilFruitState>(
        builder: (context, state) {
          switch (state.status) {
            case DevilFruitStatus.loading:
              return const ScreenLoadingState();

            case DevilFruitStatus.loaded:
              return const SafeArea(
                child: HomeBottomNavigationBar(),
              );

            case DevilFruitStatus.error:
              return const ScreenErrorState();
          }
        },
      ),
    );
  }
}
