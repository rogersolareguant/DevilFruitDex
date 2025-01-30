import 'package:devilfruitdex/presentation/screen/login/cubit/login_cubit.dart';
import 'package:devilfruitdex/presentation/screen/login/login/widgets/button_login.dart';
import 'package:devilfruitdex/presentation/screen/login/login/widgets/formulario_login.dart';
import 'package:devilfruitdex/presentation/screen/login/login/widgets/new_here.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginScreenInitial extends StatelessWidget {
  const LoginScreenInitial({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocBuilder<LoginCubit, LoginState>(builder: (context, state) {
      return Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              AppLocalizations.of(context)!.loginPage,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          if (state.error.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                state.error,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: FormularioLogin(),
          ),
          ButtonLogin(),
          const NewHere()
        ],
      );
    }));
  }
}
