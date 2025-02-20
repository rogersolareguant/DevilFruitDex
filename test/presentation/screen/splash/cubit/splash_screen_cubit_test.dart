import 'package:bloc_test/bloc_test.dart';
import 'package:devilfruitdex/domain/repository/user_repository.dart';
import 'package:devilfruitdex/presentation/screen/splash/cubit/splash_screen_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'splash_screen_cubit_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<UserRepository>(),
  MockSpec<User>(),
])
void main() {
  late SplashScreenCubit cubit;
  late MockAuthenticationRepository mockAuthRepository;
  late MockUser mockUser;

  setUp(() {
    mockAuthRepository = MockAuthenticationRepository();
    mockUser = MockUser();

    cubit = SplashScreenCubit(repository: mockAuthRepository);
  });

  group('SplashScreenCubitTest', () {
    group('Creation', () {
      test('Can be created', () {
        final instance =
            SplashScreenCubit(repository: MockAuthenticationRepository());

        expect(instance.state, const SplashScreenState());
      });
    });

    group('userLoaded', () {
      blocTest<SplashScreenCubit, SplashScreenState>(
          'emit [SplashScreenStatus.loading and SplashScreenStatus.authenticated] when response is success',
          build: () => cubit,
          setUp: () {
            when(mockAuthRepository.userLoaded())
                .thenAnswer((_) => Future.value(mockUser));
          },
          act: (cubit) => cubit.userLoaded(),
          expect: () => <SplashScreenState>[
                const SplashScreenState(
                  status: SplashScreenStatus.loading,
                ),
                const SplashScreenState(
                  status: SplashScreenStatus.authenticated,
                )
              ]);

      blocTest<SplashScreenCubit, SplashScreenState>(
          'emit [SplashScreenStatus.loading and SplashScreenStatus.unauthenticated] when response is success',
          build: () => cubit,
          setUp: () {
            when(mockAuthRepository.userLoaded())
                .thenAnswer((_) => Future.value(null));
          },
          act: (cubit) => cubit.userLoaded(),
          expect: () => <SplashScreenState>[
                const SplashScreenState(
                  status: SplashScreenStatus.loading,
                ),
                const SplashScreenState(
                  status: SplashScreenStatus.unauthenticated,
                )
              ]);

      blocTest<SplashScreenCubit, SplashScreenState>(
          'emit [SplashScreenStatus.error] when response is not success',
          build: () => cubit,
          setUp: () {
            when(mockAuthRepository.userLoaded()).thenThrow(Exception());
          },
          act: (cubit) => cubit.userLoaded(),
          expect: () => <SplashScreenState>[
                const SplashScreenState(
                  status: SplashScreenStatus.loading,
                ),
                const SplashScreenState(
                  status: SplashScreenStatus.error,
                )
              ]);
    });
  });
}
