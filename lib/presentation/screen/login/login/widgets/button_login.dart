import 'package:devilfruitdex/presentation/screen/login/cubit/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

class ButtonLogin extends StatelessWidget {
  final formKey = GlobalKey<FormState>();

  ButtonLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 0.6,
      child: ElevatedButton(
          style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(
                  Theme.of(context).dialogBackgroundColor)),
          onPressed: () async {
            try {
              final credentials = await context.read<LoginCubit>().login();

              if (credentials != null && credentials.user != null) {
                if (context.mounted) {
                  context.go('/home');
                }
              } else {
                if (context.mounted) {
                  context.read<LoginCubit>().updateError(
                        AppLocalizations.of(context)!.notFoundUser,
                      );
                }
              }
            } catch (e) {
              if (context.mounted) {
                context.read<LoginCubit>().updateError(
                      AppLocalizations.of(context)!.notFoundUser,
                    );
              }
            }
          },
          child: Text(
            AppLocalizations.of(context)!.login,
            style: Theme.of(context).textTheme.bodyMedium,
          )),
    );
  }
}
