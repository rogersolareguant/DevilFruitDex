import 'package:devilfruitdex/presentation/screen/home/bottom_navigation_bar/views/settings/cubit/settings_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
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
                      child: LanguageSetting(),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                      child: AppThemeSetting(),
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
                      context.read<SettingsCubit>().updateLanguage(selectedLanguage);
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
