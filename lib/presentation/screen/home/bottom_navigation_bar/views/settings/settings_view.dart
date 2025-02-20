import 'package:devilfruitdex/presentation/extensions/extensions.dart';
import 'package:devilfruitdex/presentation/screen/home/bottom_navigation_bar/views/settings/cubit/settings_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

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
              children: const [
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
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                      child: SignOutButton(),
                    )
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
    context.read<SettingsCubit>().getEmail();

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
                          image: AssetImage(
                              '/Users/rogersolareguant/Desktop/Flutter/devilfruitdex/assets/images/user-profile.webp'),
                          fit: BoxFit.contain))),
              Row(
                mainAxisAlignment: MainAxisAlignment.center, 
                children: [
                  Text(
                    state.email.userName(),
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  SizedBox(width: 5),
                  Icon(Icons.edit),
                
                ]
              ),
              Text(
                state.email,
                style: Theme.of(context).textTheme.bodyMedium,
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
    final Locale currentLanguage =
        context.watch<SettingsCubit>().state.language;

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
                  iconEnabledColor: Theme.of(context).scaffoldBackgroundColor,
                  value: currentLanguage,
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
  }
}

class AppThemeSetting extends StatelessWidget {
  const AppThemeSetting({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = context.watch<SettingsCubit>().state.darkMode;

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
                inactiveThumbColor: Theme.of(context).scaffoldBackgroundColor,
                trackOutlineWidth: WidgetStateProperty.all(-1),
                trackColor: WidgetStateProperty.all(Colors.white),
                value: isDarkMode,
                onChanged: (value) {
                  context.read<SettingsCubit>().updateAppTheme(value);
                },
              ),
            ),
          ),
        ],
      ),
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
        context.read<SettingsCubit>().signOut;
        context.go('/login');
      },
      child: Text(
        AppLocalizations.of(context)!.signOut,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }
}
