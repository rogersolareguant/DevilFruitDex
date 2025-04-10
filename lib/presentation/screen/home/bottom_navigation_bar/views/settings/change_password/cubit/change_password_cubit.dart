import 'package:bloc/bloc.dart';
import 'package:devilfruitdex/domain/repository/user_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'change_password_state.dart';
part 'change_password_cubit.freezed.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  final UserRepository _repository;

  ChangePasswordCubit({required UserRepository repository})
      : _repository = repository,
        super(const ChangePasswordState());

  void updateCurrentPassword(String password) {
    emit(state.copyWith(currentPassword: password));
  }

  void updateNewPassword(String password) {
    emit(state.copyWith(newPassword: password));
  }

  void updateRepeatNewPassword(String password) {
    emit(state.copyWith(repeatNewPassword: password));
  }

  void updateCurrentPasswordError(String error) {
    emit(state.copyWith(currentPasswordError: error));
  }

  void updateNewPasswordError(String error) {
    emit(state.copyWith(newPasswordError: error));
  }

  void updateRepeatNewPasswordError(String error) {
    emit(state.copyWith(repeatNewPasswordError: error));
  }

  Future<void> changePassword() async {
    bool hasError = false;

    if (state.currentPassword.isEmpty) {
      updateCurrentPasswordError('Current password is required');
      hasError = true;
    } else {
      try {
        await _repository.reauthenticateWithPassword(state.currentPassword);
        updateCurrentPasswordError('');
        hasError = false;
      } catch (e) {
        updateCurrentPasswordError('The current password is incorrect');
        hasError = true;
      }
    }

    if (state.newPassword.isEmpty) {
      updateNewPasswordError('New password is required');
      hasError = true;
    } else if (state.newPassword.length < 6) {
      updateNewPasswordError('Password too short');
      hasError = true;
    } else {
      updateNewPasswordError('');
    }

    if (state.repeatNewPassword.isEmpty) {
      updateRepeatNewPasswordError('Repeat password is required');
      hasError = true;
    } else if (state.newPassword != state.repeatNewPassword) {
      updateRepeatNewPasswordError('Passwords do not match');
      hasError = true;
    } else {
      updateRepeatNewPasswordError('');
    }

    if (hasError) return;

    emit(state.copyWith(status: ChangePasswordStatus.loading));

    try {
      await _repository.updateUserPassword(state.newPassword);
      emit(state.copyWith(status: ChangePasswordStatus.loaded));

    } catch (e) {
      emit(state.copyWith(status: ChangePasswordStatus.error));
    }
  }
}
