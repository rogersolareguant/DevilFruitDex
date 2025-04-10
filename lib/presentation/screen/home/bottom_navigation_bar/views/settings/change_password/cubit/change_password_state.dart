part of 'change_password_cubit.dart';

enum ChangePasswordStatus { init, loaded, loading, error }

@freezed
class ChangePasswordState with _$ChangePasswordState {
  const factory ChangePasswordState({
    @Default(ChangePasswordStatus.init) ChangePasswordStatus status,
    @Default('') String currentPassword,
    @Default('') String newPassword,
    @Default('') String repeatNewPassword,
    @Default('') String currentPasswordError,
    @Default('') String newPasswordError,
    @Default('') String repeatNewPasswordError,
     }) = _ChangePasswordState;
}
