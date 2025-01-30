import 'package:devilfruitdex/presentation/screen/login/cubit/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FormularioCreateUser extends StatelessWidget {
  const FormularioCreateUser({super.key});

  @override
  Widget build(BuildContext context) {
    return const Form(
        child: Column(
      children: [BuildEmail(), SizedBox(height: 12), BuildPassword()],
    ));
  }
}

class BuildEmail extends StatelessWidget {
  const BuildEmail({super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        errorStyle: TextStyle(color: Theme.of(context).focusColor),
        labelText: AppLocalizations.of(context)!.email,
        labelStyle: Theme.of(context).textTheme.bodyLarge,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide:
              BorderSide(color: Theme.of(context).dialogBackgroundColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: Theme.of(context).focusColor),
        ),
      ),
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        final emailRegex =
            RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
        if (value!.isEmpty || !emailRegex.hasMatch(value)) {
          context
              .read<LoginCubit>()
              .updateError(AppLocalizations.of(context)!.requiredField);
        }
        return null;
      },
      onChanged: (String? value) {
        context.read<LoginCubit>().updateEmail(value!);
      },
    );
  }
}

class BuildPassword extends StatelessWidget {
  const BuildPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        errorStyle: TextStyle(color: Theme.of(context).focusColor),
        labelText: AppLocalizations.of(context)!.password,
        labelStyle: Theme.of(context).textTheme.bodyLarge,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide:
              BorderSide(color: Theme.of(context).dialogBackgroundColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: Theme.of(context).focusColor),
        ),
      ),
      obscureText: true,
      validator: (value) {
        if (value!.isEmpty) {
          return AppLocalizations.of(context)!.requiredField;
        }
        return null;
      },
      onChanged: (String? value) {
        context.read<LoginCubit>().updatePassword(value!);
      },
    );
  }
}
