import 'package:devilfruitdex/presentation/screen/login/cubit/login_cubit.dart';
import 'package:devilfruitdex/presentation/screen/login/login/widgets/button_login.dart';
import 'package:devilfruitdex/presentation/screen/login/login/widgets/formulario_login.dart';
import 'package:devilfruitdex/presentation/screen/login/login/widgets/new_here.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

class LoginScreenInitial extends StatefulWidget {
  const LoginScreenInitial({super.key});

  @override
  State<LoginScreenInitial> createState() => _LoginScreenInitialState();
}

class _LoginScreenInitialState extends State<LoginScreenInitial>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

@override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(AppLocalizations.of(context)!.welcomeBack,
                style: Theme.of(context).textTheme.displayMedium,
                textAlign: TextAlign.center),
            backgroundColor: Theme.of(context).cardColor),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state.status == LoginStatus.error) {
          context.go('/no-connection-login');
        }
      },
      child: Scaffold(
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
        }),
      ),
    );
  }
}
