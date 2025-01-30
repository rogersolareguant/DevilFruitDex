import 'package:devilfruitdex/presentation/screen/login/cubit/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

class ButtonCreateUser extends StatelessWidget {
  final formKey = GlobalKey<FormState>();

  ButtonCreateUser({super.key});

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
              final credentials = await context.read<LoginCubit>().create();

              if (credentials != null && credentials.user != null) {
                if (context.mounted) {
                  context.read<LoginCubit>().updateError(
                        AppLocalizations.of(context)!.succesUserCreation,
                      );
                }

                Future.delayed(const Duration(seconds: 2), () {
                  if (context.mounted) {
                    context.go('/login');
                  }
                });
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
            AppLocalizations.of(context)!.register,
            style: Theme.of(context).textTheme.bodyMedium,
          )),
    );
  }
}
