part of 'settings_cubit.dart';

enum SettingsStatus { loading, loaded, error }

@freezed
class SettingsState with _$SettingsState {
  const factory SettingsState({
    @Default(SettingsStatus.loading) SettingsStatus status,
    @Default(false) bool darkMode,
    @Default(Locale('en')) Locale language,
    @Default('') String name,
    @Default('') String email,
    @Default('') String currentPassword,
    @Default('') String newPassword,
    @Default('') String repeatNewPassword,
    @Default('') String currentPasswordError,
    @Default('') String newPasswordError,
    @Default('') String repeatNewPasswordError,
  }) = _SettingState;
}
