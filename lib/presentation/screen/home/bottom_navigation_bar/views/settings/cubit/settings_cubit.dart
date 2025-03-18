import 'package:bloc/bloc.dart';
import 'package:devilfruitdex/domain/repository/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'settings_state.dart';
part 'settings_cubit.freezed.dart';

class SettingsCubit extends Cubit<SettingsState> {
  final UserRepository _repository;

  SettingsCubit({required UserRepository repository})
      : _repository = repository,
        super(const SettingsState());

  void updateAppTheme(bool darkMode) {
    emit(state.copyWith(
      darkMode: darkMode,
    ));
  }

  void updateLanguage(Locale language) {
    emit(state.copyWith(
      language: language,
    ));
  }

  Future<void> loadUserName() async {
    final prefs = await SharedPreferences.getInstance();
    final savedName = prefs.getString('userName') ?? '';

    emit(state.copyWith(name: savedName));
  }

  Future<void> updateName(String name) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userName', name);

    emit(state.copyWith(name: name));
  }

  Future<void> getEmail() async {
    try {
      String? email = await _repository.getEmail();
      if (email != null) {
        emit(state.copyWith(
          status: SettingsStatus.loaded,
          email: email,
        ));
      } else {
        emit(state.copyWith(
          status: SettingsStatus.error,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        status: SettingsStatus.error,
      ));
    }
  }

  void updateCurrentPassword(String password) {
    emit(state.copyWith(currentPassword: password));
  }

  void updateNewPassword(String password) {
    emit(state.copyWith(newPassword: password));
  }

  void updateRepeatNewPassword(String password) {
    emit(state.copyWith(repeatNewPassword: password));
  }

  Future<bool> updatePassword() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      AuthCredential credential = EmailAuthProvider.credential(
        email: user!.email!,
        password: state.currentPassword,
      );

      await user.reauthenticateWithCredential(credential);

      await user.updatePassword(state.newPassword);
      return true; 
    } catch (e) {
      return false; 
    }
  }

  void signOut() {
    FirebaseAuth.instance.signOut();
    emit(state.copyWith(
      status: SettingsStatus.loading,
    ));
  }
}
