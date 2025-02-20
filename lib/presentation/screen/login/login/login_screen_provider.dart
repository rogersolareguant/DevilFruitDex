import 'package:devilfruitdex/domain/repository/user_repository.dart';
import 'package:devilfruitdex/presentation/screen/login/cubit/login_cubit.dart';
import 'package:devilfruitdex/presentation/screen/login/login/login_screen_initial.dart';
import 'package:devilfruitdex/presentation/screen/widgets/screen_error_state.dart';
import 'package:devilfruitdex/presentation/screen/widgets/screen_loading_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreenProvider extends StatelessWidget {
  const LoginScreenProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          LoginCubit(repository: context.read<UserRepository>()),
      child: const LoginScreen(),
    );
  }
}

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<LoginCubit, LoginState>(
        builder: (context, state) {
          switch (state.status) {
            case LoginStatus.initial:
              return const LoginScreenInitial();

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
