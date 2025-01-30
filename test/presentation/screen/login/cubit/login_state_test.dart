import 'package:devilfruitdex/presentation/screen/login/cubit/login_cubit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('LoginStateTest', () {
    group('Creation', () {
      test('Can be created', () {
        const instance = LoginState(
          status: LoginStatus.initial,
          email: '',
          password: '',
          error: '',
        );

        expect(instance, isNotNull);
        expect(instance.status, LoginStatus.initial);
        expect(instance.email, '');
        expect(instance.password, '');
        expect(instance.error, '');
      });
    });
  });
}
