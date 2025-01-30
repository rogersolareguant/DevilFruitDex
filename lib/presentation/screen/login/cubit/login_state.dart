part of 'login_cubit.dart';

enum LoginStatus { initial, loading, error }

@freezed
class LoginState with _$LoginState {
  const factory LoginState({
    @Default(LoginStatus.initial) LoginStatus status,
    @Default('') String email,
    @Default('') String password,
    @Default('') String error,
  }) = _LoginState;
}

