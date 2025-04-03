import 'package:devilfruitdex/presentation/extensions/extensions.dart';
import 'package:devilfruitdex/presentation/screen/home/bottom_navigation_bar/views/settings/cubit/settings_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(builder: (context, state) {
      return Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Container(
            decoration: BoxDecoration(
                color: Theme.of(context).dialogBackgroundColor,
                borderRadius: BorderRadius.circular(10)),
            child: ListView(
              padding: const EdgeInsets.all(15),
              children: [
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                      child: UserProfileSection(),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                      child: LanguageSetting(),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                      child: AppThemeSetting(),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(85, 0, 0, 0),
                          child: SignOutButton(),
                        ),
                        SizedBox(width: 25),
                        Center(
                        child: Lottie.asset(
                          'assets/animations/bee.json',
                          width: 50,
                                height: 30,
                                fit: BoxFit.cover,))
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}

class UserProfileSection extends StatelessWidget {
  const UserProfileSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        bool visibleCurrentPassword = true;
        bool visibleNewPassword = true;
        bool visibleRepeatPassword = true;

        return Container(
          padding: const EdgeInsets.fromLTRB(70, 15, 70, 15),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              Container(
                  width: 1000,
                  height: 100,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: AssetImage('assets/images/user-profile.webp'),
                          fit: BoxFit.contain))),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text(
                    state.name.isEmpty ? state.email.userName() : state.name,
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                  IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return BlocProvider.value(
                              value: context.read<SettingsCubit>(),
                              child: AlertDialog(
                                title: Text(
                                  AppLocalizations.of(context)!.editName,
                                  style:
                                      Theme.of(context).textTheme.displayMedium,
                                ),
                                content: TextField(
                                  maxLength: 7,
                                  onChanged: (value) {
                                    if (value.length <= 7) {
                                      context
                                          .read<SettingsCubit>()
                                          .updateName(value);
                                    }
                                  },
                                  style: TextStyle(
                                      color: Theme.of(context).focusColor),
                                  decoration: InputDecoration(
                                    counterText: "",
                                    hintText: AppLocalizations.of(context)!
                                        .enterYourName,
                                    hintStyle: TextStyle(
                                        color: Theme.of(context).canvasColor,
                                        fontSize: 15),
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: Text(
                                      AppLocalizations.of(context)!.save,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      })
                ]),
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(
                  state.email,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                IconButton(
                  icon: const Icon(Icons.change_circle_outlined),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return BlocProvider.value(
                          value: context.read<SettingsCubit>(),
                          child: BlocBuilder<SettingsCubit, SettingsState>(
                            builder: (context, state) {
                              return AlertDialog(
                                title: Text(
                                  AppLocalizations.of(context)!.updatePassword,
                                  style:
                                      Theme.of(context).textTheme.displayMedium,
                                ),
                                content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      TextField(
                                        obscureText: visibleCurrentPassword,
                                        onChanged: (value) {
                                          context
                                              .read<SettingsCubit>()
                                              .updateCurrentPassword(value);
                                        },
                                        style: TextStyle(
                                            color:
                                                Theme.of(context).focusColor),
                                        decoration: InputDecoration(
                                            hintText:
                                                AppLocalizations.of(context)!
                                                    .currentPassword,
                                            hintStyle: TextStyle(
                                                color: Theme.of(context)
                                                    .canvasColor,
                                                fontSize: 15),
                                            border: OutlineInputBorder(),
                                            errorText: state
                                                    .currentPasswordError
                                                    .isNotEmpty
                                                ? state.currentPasswordError
                                                : null,
                                            suffixIcon: IconButton(
                                              onPressed: () {
                                                visibleCurrentPassword =
                                                    !visibleCurrentPassword;
                                              },
                                              icon: Icon(
                                                visibleCurrentPassword
                                                    ? Icons.visibility_off
                                                    : Icons.visibility,
                                              ),
                                            )),
                                      ),
                                      SizedBox(height: 10),
                                      TextField(
                                        obscureText: visibleNewPassword,
                                        onChanged: (value) {
                                          context
                                              .read<SettingsCubit>()
                                              .updateNewPassword(value);
                                        },
                                        style: TextStyle(
                                            color:
                                                Theme.of(context).focusColor),
                                        decoration: InputDecoration(
                                            hintText:
                                                AppLocalizations.of(context)!
                                                    .newPassword,
                                            hintStyle: TextStyle(
                                                color: Theme.of(context)
                                                    .canvasColor,
                                                fontSize: 15),
                                            border: OutlineInputBorder(),
                                            errorText: state
                                                    .newPasswordError.isNotEmpty
                                                ? state.newPasswordError
                                                : null,
                                            suffixIcon: IconButton(
                                              onPressed: () {
                                                visibleNewPassword =
                                                    !visibleNewPassword;
                                              },
                                              icon: Icon(
                                                visibleNewPassword
                                                    ? Icons.visibility_off
                                                    : Icons.visibility,
                                              ),
                                            )),
                                      ),
                                      SizedBox(height: 10),
                                      TextField(
                                        obscureText: visibleRepeatPassword,
                                        onChanged: (value) {
                                          context
                                              .read<SettingsCubit>()
                                              .updateRepeatNewPassword(value);
                                        },
                                        style: TextStyle(
                                            color:
                                                Theme.of(context).focusColor),
                                        decoration: InputDecoration(
                                            hintText:
                                                AppLocalizations.of(context)!
                                                    .repeatPassword,
                                            hintStyle: TextStyle(
                                                color: Theme.of(context)
                                                    .canvasColor,
                                                fontSize: 15),
                                            border: OutlineInputBorder(),
                                            errorText: state
                                                    .repeatNewPasswordError
                                                    .isNotEmpty
                                                ? state.repeatNewPasswordError
                                                : null,
                                            suffixIcon: IconButton(
                                              onPressed: () {
                                                visibleRepeatPassword =
                                                    !visibleRepeatPassword;
                                              },
                                              icon: Icon(
                                                visibleRepeatPassword
                                                    ? Icons.visibility_off
                                                    : Icons.visibility,
                                              ),
                                            )),
                                      ),
                                    ]),
                                actions: [
                                  TextButton(
                                    onPressed: () async {
                                      final settingsCubit =
                                          context.read<SettingsCubit>();

                                      if (state.currentPassword.isEmpty) {
                                        context
                                            .read<SettingsCubit>()
                                            .updateCurrentPasswordError(
                                                AppLocalizations.of(context)!
                                                    .requiredField);
                                      } else {
                                        final isCurrentPasswordOk =
                                            await settingsCubit
                                                .checkCurrentPasswordOk();

                                        if (!context.mounted) return;

                                        if (!isCurrentPasswordOk) {
                                          context
                                              .read<SettingsCubit>()
                                              .updateCurrentPasswordError(
                                                  AppLocalizations.of(context)!
                                                      .incorrectCurrentPassword);
                                        } else {
                                          context
                                              .read<SettingsCubit>()
                                              .updateCurrentPasswordError('');
                                        }
                                      }

                                      if (state.newPassword.isEmpty) {
                                        context
                                            .read<SettingsCubit>()
                                            .updateNewPasswordError(
                                                AppLocalizations.of(context)!
                                                    .requiredField);
                                      } else if (state.newPassword.length < 6) {
                                        context
                                            .read<SettingsCubit>()
                                            .updateNewPasswordError(
                                                AppLocalizations.of(context)!
                                                    .weakPassword);
                                      }

                                      if (state.repeatNewPassword.isEmpty) {
                                        context
                                            .read<SettingsCubit>()
                                            .updateRepeatNewPasswordError(
                                                AppLocalizations.of(context)!
                                                    .requiredField);
                                      } else if (state.repeatNewPassword !=
                                          state.newPassword) {
                                        context
                                            .read<SettingsCubit>()
                                            .updateRepeatNewPasswordError(
                                                AppLocalizations.of(context)!
                                                    .notMatch);
                                      } else {
                                        final isPasswordUpdated =
                                            await settingsCubit
                                                .updatePasswordOk();

                                        if (!context.mounted) return;

                                        if (isPasswordUpdated) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                  AppLocalizations.of(context)!
                                                      .changedSucces),
                                              backgroundColor: Colors.green,
                                            ),
                                          );
                                          Navigator.pop(context);
                                        } else {
                                          context
                                              .read<SettingsCubit>()
                                              .updateCurrentPasswordError(
                                                  AppLocalizations.of(context)!
                                                      .incorrectCurrentPassword);
                                        }
                                      }
                                    },
                                    child: Text(
                                        AppLocalizations.of(context)!.save),
                                  ),
                                ],
                              );
                            },
                          ),
                        );
                      },
                    );
                  },
                )
              ]),
            ],
          ),
        );
      },
    );
  }
}

class LanguageSetting extends StatelessWidget {
  const LanguageSetting({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        return Container(
          decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              border: Border.all(color: Theme.of(context).cardColor, width: 3),
              borderRadius: BorderRadius.circular(10)),
          height: 100,
          width: 1000,
          child: Row(
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(20, 20, 5, 20),
                child: Icon(Icons.language),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(5, 20, 0, 20),
                child: Text(
                  AppLocalizations.of(context)!.language,
                  style: Theme.of(context).textTheme.displayMedium,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(50, 20, 30, 20),
                  child: DropdownButton(
                      dropdownColor: Theme.of(context).dialogBackgroundColor,
                      iconEnabledColor:
                          Theme.of(context).scaffoldBackgroundColor,
                      value: state.language,
                      onChanged: (selectedLanguage) {
                        if (selectedLanguage != null) {
                          context
                              .read<SettingsCubit>()
                              .updateLanguage(selectedLanguage);
                        }
                      },
                      items: [
                        DropdownMenuItem(
                            value: const Locale('en'),
                            child: Text(
                              AppLocalizations.of(context)!.english,
                              style: Theme.of(context).textTheme.bodyMedium,
                            )),
                        DropdownMenuItem(
                            value: const Locale('es'),
                            child: Text(
                              AppLocalizations.of(context)!.spanish,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ))
                      ]),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class AppThemeSetting extends StatelessWidget {
  const AppThemeSetting({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        return Container(
          decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              border: Border.all(color: Theme.of(context).cardColor, width: 3),
              borderRadius: BorderRadius.circular(10)),
          height: 100,
          width: 1000,
          child: Row(
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(20, 20, 5, 20),
                child: Icon(Icons.dark_mode_outlined),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(5, 20, 0, 20),
                child: Text(
                  AppLocalizations.of(context)!.darkMode,
                  style: Theme.of(context).textTheme.displayMedium,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Switch(
                    inactiveThumbColor:
                        Theme.of(context).scaffoldBackgroundColor,
                    trackOutlineWidth: WidgetStateProperty.all(-1),
                    trackColor: WidgetStateProperty.all(Colors.white),
                    value: state.darkMode,
                    onChanged: (value) {
                      context.read<SettingsCubit>().updateAppTheme(value);
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class SignOutButton extends StatelessWidget {
  const SignOutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      style: ButtonStyle(
          backgroundColor:
              WidgetStateProperty.all(Theme.of(context).cardColor)),
      onPressed: () {
        context.read<SettingsCubit>().signOut();
        context.go('/login');
      },
      child: Text(
        AppLocalizations.of(context)!.signOut,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }
}
