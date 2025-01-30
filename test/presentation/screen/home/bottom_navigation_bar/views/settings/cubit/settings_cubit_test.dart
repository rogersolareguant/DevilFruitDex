import 'package:bloc_test/bloc_test.dart';
import 'package:devilfruitdex/presentation/screen/home/bottom_navigation_bar/views/settings/cubit/settings_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {

  late SettingsCubit cubit;

  setUp(() {
    cubit = SettingsCubit();
  });

  group('SettingsCubitTest', () {

    group(
      'Creation', 
      () {
        test('Can be created', () {
          final instance = SettingsCubit();

          expect(instance.state, SettingsState());
        }
        
        );
    });

    group('updateAppTheme', () {
      blocTest<SettingsCubit, SettingsState>(
        'emits [darkMode] when the update is true.',
        build: () => cubit,
        act: (cubit) => cubit.updateAppTheme(true),
        expect: () => const <SettingsState>[SettingsState(darkMode: true)],
      );

      blocTest<SettingsCubit, SettingsState>(
        'emits [no darkMode] when the update is false.',
        build: () => cubit,
        act: (cubit) => cubit.updateAppTheme(false),
        expect: () => const <SettingsState>[SettingsState(darkMode: false)],
      );
    });

    group('updateLanguage', () {
      blocTest<SettingsCubit, SettingsState>(
        'emits [language español] when the language español is successfully selected.',
        build: () => cubit,
        act: (cubit) => cubit.updateLanguage(Locale('es')),
        expect: () => const <SettingsState>[SettingsState(language: Locale('es'))],
      );

      blocTest<SettingsCubit, SettingsState>(
        'emits [language english] when a language english is successfully selected.',
        build: () => cubit,
        act: (cubit) => cubit.updateLanguage(Locale('en')),
        expect: () => const <SettingsState>[SettingsState(language: Locale('en'))],
      );
    });

  });
}

