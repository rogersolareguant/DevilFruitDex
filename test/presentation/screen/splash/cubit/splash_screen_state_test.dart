import 'package:devilfruitdex/presentation/screen/splash/cubit/splash_screen_cubit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {

  group('SplashScreenStateTest', () {

    group('Creation', () {

      test('Can be created', () {
        const instance = SplashScreenState(
          status: SplashScreenStatus.loading,
        );


        expect(instance, isNotNull);
        expect(instance.status, SplashScreenStatus.loading);
      
      });
    });

  });
}