import 'package:devilfruitdex/presentation/screen/home/bottom_navigation_bar/views/settings/cubit/settings_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';


void main() {

  group('SettingsStateTest', () {

    group('Creation', () {

      test('Can be created', () {
        const instance = SettingsState(
          status: SettingsStatus.loading,
          darkMode: false,
          language: Locale('en'),
        );


        expect(instance, isNotNull);
        expect(instance.status, SettingsStatus.loading);
        expect(instance.darkMode, false);
        expect(instance.language, Locale('en'));
      
      });
    });

  });
}