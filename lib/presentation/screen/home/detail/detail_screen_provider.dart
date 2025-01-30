import 'package:devilfruitdex/domain/repository/devil_fruit_repository.dart';
import 'package:devilfruitdex/domain/repository/favourites_repository.dart';
import 'package:devilfruitdex/domain/repository/location_repository.dart';
import 'package:devilfruitdex/presentation/screen/home/cubit/devil_fruit_cubit.dart';
import 'package:devilfruitdex/presentation/screen/home/detail/detail_loaded.dart';
import 'package:devilfruitdex/presentation/screen/widgets/screen_error_state.dart';
import 'package:devilfruitdex/presentation/screen/widgets/screen_loading_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class DetailScreenProvider extends StatelessWidget {
  final String id;

  const DetailScreenProvider({super.key, required this.id});

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
          uid: currentUser.uid)
        ..getAllDevilFruits(),
      child: DetailScreen(id: id),
    );
  }
}

class DetailScreen extends StatelessWidget {
  final String id;

  const DetailScreen({
    super.key,
    required this.id,
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
              return DetailLoaded(
                  devilFruit: state.devilFruit[int.parse(id) - 1]);

            case DevilFruitStatus.error:
              return const ScreenErrorState();
          }
        },
      ),
    );
  }
}
