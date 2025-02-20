import 'package:bloc_test/bloc_test.dart';
import 'package:devilfruitdex/domain/repository/user_repository.dart';
import 'package:devilfruitdex/presentation/screen/login/cubit/login_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'login_cubit_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<UserRepository>(),
  MockSpec<UserCredential>(),
])
void main() {
  late LoginCubit cubit;
  late MockAuthenticationRepository mockAuthRepository;
  late MockUserCredential mockUserCredential;

  const String email = 'aa@a.com';
  const String password = '1234567';
  const String error = 'user-not-found';

  setUp(() {
    mockAuthRepository = MockAuthenticationRepository();
    mockUserCredential = MockUserCredential();

    cubit = LoginCubit(repository: mockAuthRepository);
  });

  group('LoginCubit Tests', () {
    group('Creaion', () {
      test('Can be created', () {
        final instance = LoginCubit(repository: MockAuthenticationRepository());

        expect(instance.state, const LoginState());
      });
    });

    group('login', () {
      blocTest<LoginCubit, LoginState>(
          'emit [LoginStatus.initial] when response is success',
          build: () => cubit,
          setUp: () {
            when(mockAuthRepository.login(email, password))
                .thenAnswer((_) => Future.value(mockUserCredential));
          },
          act: (cubit) => cubit.login(),
          expect: () => <LoginState>[
                const LoginState(
                  status: LoginStatus.initial,
                )
              ]);
    });

    group('create', () {
      blocTest<LoginCubit, LoginState>(
          'emit [LoginStatus.initial] when response is success',
          build: () => cubit,
          setUp: () {
            when(mockAuthRepository.create(email, password))
                .thenAnswer((_) => Future.value(mockUserCredential));
          },
          act: (cubit) => cubit.create(),
          expect: () => <LoginState>[
                const LoginState(
                  status: LoginStatus.initial,
                )
              ]);
    });

    group('updateEmail', () {
      blocTest<LoginCubit, LoginState>(
        'emit [state.status] when we update email',
        build: () => cubit,
        act: (cubit) => cubit.updateEmail(email),
        expect: () => <LoginState>[
          const LoginState(email: email),
        ],
      );
    });

    group('updatePassword', () {
      blocTest<LoginCubit, LoginState>(
        'emit [state.status] when we update password',
        build: () => cubit,
        act: (cubit) => cubit.updatePassword(password),
        expect: () => <LoginState>[
          const LoginState(password: password),
        ],
      );
    });

    group('updateError', () {
      blocTest<LoginCubit, LoginState>(
        'emit [state.status] when we update error',
        build: () => cubit,
        act: (cubit) => cubit.updateError(error),
        expect: () => <LoginState>[
          const LoginState(error: error),
        ],
      );
    });
  });
}
