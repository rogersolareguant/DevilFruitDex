import 'package:devilfruitdex/presentation/screen/home/bottom_navigation_bar/views/settings/change_password/cubit/change_password_cubit.dart';
import 'package:devilfruitdex/presentation/screen/home/detail/widgets/app_bar_widgets/go_back_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ChangePassword extends StatelessWidget {
  const ChangePassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const GoBackButton(),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                AppLocalizations.of(context)!.updatePassword,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 24),
              const FormularioChangePassword(),
              const SizedBox(height: 24),
              const ButtonSave(),
            ],
          ),
        ),
      ),
    );
  }
}

class FormularioChangePassword extends StatelessWidget {
  const FormularioChangePassword({super.key});

  @override
  Widget build(BuildContext context) {
    return const Form(
        child: Column(
      children: [
        BuildCurrentPassword(),
        SizedBox(height: 12),
        BuildNewPassword(),
        SizedBox(height: 12),
        BuildRepeatNewPassword()
      ],
    ));
  }
}

class BuildCurrentPassword extends StatelessWidget {
  const BuildCurrentPassword({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<ChangePasswordCubit>().state;
    ValueNotifier<bool> obscureTextNotifier = ValueNotifier(true);

    return ValueListenableBuilder<bool>(
      valueListenable: obscureTextNotifier,
      builder: (context, obscureText, child) {
        return TextFormField(
          decoration: InputDecoration(
            errorText: state.currentPasswordError.isNotEmpty
                ? state.currentPasswordError
                : null,
            errorStyle: TextStyle(color: Theme.of(context).focusColor),
            labelText: AppLocalizations.of(context)!.currentPassword,
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
            suffixIcon: IconButton(
              icon: Icon(
                obscureText ? Icons.visibility_off : Icons.visibility,
                color: Theme.of(context).dialogBackgroundColor,
              ),
              onPressed: () {
                obscureTextNotifier.value = !obscureTextNotifier.value;
              },
            ),
          ),
          obscureText: obscureText,
          onChanged: (value) {
            context.read<ChangePasswordCubit>().updateCurrentPassword(value);
          },
        );
      },
    );
  }
}

class BuildNewPassword extends StatelessWidget {
  const BuildNewPassword({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<ChangePasswordCubit>().state;
    ValueNotifier<bool> obscureTextNotifier = ValueNotifier(true);

    return ValueListenableBuilder<bool>(
      valueListenable: obscureTextNotifier,
      builder: (context, obscureText, child) {
        return TextFormField(
          decoration: InputDecoration(
            errorText: state.newPasswordError.isNotEmpty
                ? state.newPasswordError
                : null,
            errorStyle: TextStyle(color: Theme.of(context).focusColor),
            labelText: AppLocalizations.of(context)!.newPassword,
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
            suffixIcon: IconButton(
              icon: Icon(
                obscureText ? Icons.visibility_off : Icons.visibility,
                color: Theme.of(context).dialogBackgroundColor,
              ),
              onPressed: () {
                obscureTextNotifier.value = !obscureTextNotifier.value;
              },
            ),
          ),
          obscureText: obscureText,
          onChanged: (value) {
            context.read<ChangePasswordCubit>().updateNewPassword(value);
          },
        );
      },
    );
  }
}

class BuildRepeatNewPassword extends StatelessWidget {
  const BuildRepeatNewPassword({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<ChangePasswordCubit>().state;
    ValueNotifier<bool> obscureTextNotifier = ValueNotifier(true);

    return ValueListenableBuilder<bool>(
      valueListenable: obscureTextNotifier,
      builder: (context, obscureText, child) {
        return TextFormField(
          decoration: InputDecoration(
            errorText: state.repeatNewPasswordError.isNotEmpty
                ? state.repeatNewPasswordError
                : null,
            errorStyle: TextStyle(color: Theme.of(context).focusColor),
            labelText: AppLocalizations.of(context)!.repeatPassword,
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
            suffixIcon: IconButton(
              icon: Icon(
                obscureText ? Icons.visibility_off : Icons.visibility,
                color: Theme.of(context).dialogBackgroundColor,
              ),
              onPressed: () {
                obscureTextNotifier.value = !obscureTextNotifier.value;
              },
            ),
          ),
          obscureText: obscureText,
          onChanged: (value) {
            context.read<ChangePasswordCubit>().updateRepeatNewPassword(value);
          },
        );
      },
    );
  }
}

class ButtonSave extends StatelessWidget {
  const ButtonSave({super.key});

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 0.6,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(
            Theme.of(context).dialogBackgroundColor,
          ),
        ),
        onPressed: () {
          context.read<ChangePasswordCubit>().changePassword();
        },
        child: Text(
          AppLocalizations.of(context)!.save,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
    );
  }
}
