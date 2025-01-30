import 'package:devilfruitdex/domain/repository/authentication_repository.dart';
import 'package:devilfruitdex/presentation/screen/login/create_user/create_user_initial.dart';
import 'package:devilfruitdex/presentation/screen/login/cubit/login_cubit.dart';
import 'package:devilfruitdex/presentation/screen/widgets/screen_error_state.dart';
import 'package:devilfruitdex/presentation/screen/widgets/screen_loading_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateUserScreenProvider extends StatelessWidget {
  const CreateUserScreenProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          LoginCubit(repository: context.read<AuthenticationRepository>()),
      child: const CreateUserScreen(),
    );
  }
}

class CreateUserScreen extends StatelessWidget {
  const CreateUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<LoginCubit, LoginState>(
        builder: (context, state) {
          switch (state.status) {
            case LoginStatus.initial:
              return const CreateUserInitial();

            case LoginStatus.loading:
              return const ScreenLoadingState();

            case LoginStatus.error:
              return const ScreenErrorState();
          }
        },
      ),
    );
  }
}
