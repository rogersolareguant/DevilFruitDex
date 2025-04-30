import 'package:devilfruitdex/presentation/extensions/extensions.dart';
import 'package:devilfruitdex/presentation/screen/home/bottom_navigation_bar/views/settings/cubit/settings_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
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
                        fit: BoxFit.cover,
                      ))
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class UserProfileSection extends StatefulWidget {
  const UserProfileSection({super.key});

  @override
  State<UserProfileSection> createState() => _UserProfileSectionState();
}

class _UserProfileSectionState extends State<UserProfileSection> {
  final TextEditingController nameController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
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
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      state.name.isEmpty ? state.email.userName() : state.name,
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        nameController.text = state.name;

                        final platform = Theme.of(context).platform;

                        if (platform == TargetPlatform.iOS) {
                          showCupertinoDialog(
                            context: context,
                            builder: (context) {
                              return CupertinoAlertDialog(
                                title: Text(
                                    AppLocalizations.of(context)!.editName),
                                content: Column(
                                  children: [
                                    const SizedBox(height: 10),
                                    CupertinoTextField(
                                      controller: nameController,
                                      placeholder: AppLocalizations.of(context)!
                                          .enterYourName,
                                      maxLength: 7,
                                    ),
                                  ],
                                ),
                                actions: [
                                  CupertinoDialogAction(
                                    onPressed: () {
                                      final newName =
                                          nameController.text.trim();
                                      if (newName.isNotEmpty &&
                                          newName.length <= 7) {
                                        context.read<SettingsCubit>().updateName(newName);
                                      }
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                        AppLocalizations.of(context)!.save),
                                  )
                                ],
                              );
                            },
                          );
                        } else {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return BlocProvider.value(
                                value: context.read<SettingsCubit>(),
                                child: AlertDialog(
                                  title: Text(
                                    AppLocalizations.of(context)!.editName,
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayMedium,
                                  ),
                                  content: TextField(
                                    controller: nameController,
                                    maxLength: 7,
                                    style: TextStyle(
                                        color: Theme.of(context).focusColor),
                                    decoration: InputDecoration(
                                      counterText: "",
                                      hintText: AppLocalizations.of(context)!
                                          .enterYourName,
                                      hintStyle: TextStyle(
                                        color: Theme.of(context).canvasColor,
                                        fontSize: 15,
                                      ),
                                      border: const OutlineInputBorder(),
                                    ),
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        final newName =
                                            nameController.text.trim();
                                        if (newName.isNotEmpty &&
                                            newName.length <= 7) {
                                          context
                                              .read<SettingsCubit>()
                                              .updateName(
                                                  newName); // Update on save
                                        }
                                        Navigator.pop(context);
                                      },
                                      child: Text(
                                          AppLocalizations.of(context)!.save),
                                    )
                                  ],
                                ),
                              );
                            },
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    state.email,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  IconButton(
                    icon: const Icon(Icons.change_circle_outlined),
                    onPressed: () {
                      context.go('/home/changepassword');
                    },
                  ),
                ],
              ),
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
