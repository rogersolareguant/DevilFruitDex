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
    try {
      String userName = await _repository.getUserName(uid);
      emit(state.copyWith(status: SettingsStatus.loaded, name: userName));
    } catch (e) {
      emit(state.copyWith(status: SettingsStatus.error));
    }
  }

  Future<void> updateName(String userName) async {
    try {
      await _repository.setUserName(uid, userName);
      loadUserName();
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

  void signOut() async {
    FirebaseAuth.instance.signOut();
    emit(state.copyWith(status: SettingsStatus.loading));
  }

}
