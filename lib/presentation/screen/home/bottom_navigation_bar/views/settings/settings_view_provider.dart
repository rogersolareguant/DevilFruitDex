import 'package:devilfruitdex/domain/repository/user_repository.dart';
import 'package:devilfruitdex/presentation/screen/home/bottom_navigation_bar/views/settings/cubit/settings_cubit.dart';
import 'package:devilfruitdex/presentation/screen/home/bottom_navigation_bar/views/settings/settings_view.dart';
import 'package:devilfruitdex/presentation/screen/widgets/screen_error_state.dart';
import 'package:devilfruitdex/presentation/screen/widgets/screen_loading_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SettingsScreenProvider extends StatelessWidget {
  const SettingsScreenProvider({super.key});

  @override
  Widget build(BuildContext context) {

    final User? currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser == null) {
      context.go('/login');
      return const ScreenLoadingState();
    }
    return BlocProvider(
      create: (context) {
        final cubit = SettingsCubit(repository: context.read<UserRepository>(), uid: currentUser.uid);
        cubit.getEmail();
        cubit.loadUserName();
        return cubit;
      },
      child: const SettingsScreen(),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) {
          switch (state.status) {
            case SettingsStatus.loading:
              return const ScreenLoadingState();

            case SettingsStatus.loaded:
              return const SafeArea(
                child: SettingsView(),
              );

            case SettingsStatus.error:
              return const ScreenErrorState();
          }
        },
      ),
    );
  }
}
