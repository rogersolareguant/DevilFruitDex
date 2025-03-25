import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:devilfruitdex/domain/repository/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'settings_state.dart';
part 'settings_cubit.freezed.dart';

class SettingsCubit extends Cubit<SettingsState> {
  final UserRepository _repository;
  final String uid;

  SettingsCubit({required UserRepository repository, required this.uid})
      : _repository = repository,
        super(const SettingsState()) {
    initialize();
  }

  late StreamSubscription<String> _subscription;

  Future<void> initialize() async {
    await loadUserName();
    await getEmail();
    streamUserName();
  }

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
    try {
      String userName = (_repository.getUserName(uid)) as String;
      emit(state.copyWith(status: SettingsStatus.loaded, name: userName));
    } catch (e) {
      emit(state.copyWith(status: SettingsStatus.error));
    }
  }

  Future<void> updateName(String userName) async {
    try {
      await _repository.setUserName(uid, userName);
      emit(state.copyWith(status: SettingsStatus.loaded, name: userName));
    } catch (e) {
      emit(state.copyWith(status: SettingsStatus.error));
    }
  }

  Future<void> getEmail() async {
    try {
      String? email = await _repository.getEmail();

      if (email != null) {
        emit(state.copyWith(status: SettingsStatus.loaded, email: email));
      } else {
        emit(state.copyWith(status: SettingsStatus.error));
      }
    } catch (e) {
      emit(state.copyWith(status: SettingsStatus.error));
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

  Future<bool> updatePasswordOk() async {
    try {
      await _repository.reauthenticateWithPassword(state.currentPassword);
      await _repository.updateUserPassword(state.newPassword);

      emit(state.copyWith(status: SettingsStatus.loaded));

      return true;
    } catch (e) {
      emit(state.copyWith(status: SettingsStatus.error));
      return false;
    }
  }

  void streamUserName() {
    _subscription = _repository.getUserName(uid).listen((String userName) {
      emit(state.copyWith(name: userName));
    });
  }

  void signOut() async {
    FirebaseAuth.instance.signOut();
    emit(state.copyWith(status: SettingsStatus.loading));
  }

  @override
  Future<void> close() async {
    await _subscription.cancel();
    return super.close();
  }
}
