import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:devilfruitdex/domain/repository/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

part 'login_state.dart';
part 'login_cubit.freezed.dart';

class LoginCubit extends Cubit<LoginState> {
  final UserRepository _repository;
  final InternetConnectionChecker _connectionChecker;
  late StreamSubscription<InternetConnectionStatus> _connectionSubscription;

  LoginCubit(
      {required UserRepository repository,
      required InternetConnectionChecker connectionChecker})
      : _repository = repository,
        _connectionChecker = connectionChecker,
        super(const LoginState()) {
    _startChecking();
  }

  Future<UserCredential?> login() async {
    try {
      UserCredential? userCredential =
          await _repository.login(state.email, state.password);
      emit(state.copyWith(status: LoginStatus.initial));
      return userCredential;
    } on FirebaseAuthException catch (e) {
      String error = '';

      if (e.code == 'invalid-credential') {
        error = "User not found";
      } else if (e.code == 'wrong-password') {
        error = "Incorrect password";
      } else {
        error = "Login failed: ${e.message}";
      }
      emit(state.copyWith(status: LoginStatus.error, error: error));
    }
    return null;
  }

  Future<UserCredential?> create() async {
    try {
      UserCredential? userCredential =
          await _repository.create(state.email, state.password);
      emit(state.copyWith(status: LoginStatus.initial));
      return userCredential;
    } on FirebaseAuthException catch (e) {
      String error = '';

      if (e.code == 'email-already-in-use') {
        error = "The email is already in use";
        updateError(error);
      } else if (e.code == 'weak-password') {
        error = "Weak password";
      } else {
        error = "Login failed: ${e.message}";
      }
      emit(state.copyWith(status: LoginStatus.initial, error: error));
    }
    return null;
  }

  void updateEmail(String email) async {
    emit(state.copyWith(
      email: email,
    ));
  }

  void updatePassword(String password) {
    emit(state.copyWith(password: password));
  }

  void updateError(String error) {
    emit(state.copyWith(error: error));
  }

  void _startChecking() {
    _connectionSubscription =
        _connectionChecker.onStatusChange.listen((status) {
      if (status == InternetConnectionStatus.connected) {
        emit(const LoginState(status: LoginStatus.loading));
      } else {
        emit(const LoginState(status: LoginStatus.error));
      }
    });
  }

  @override
  Future<void> close() {
    _connectionSubscription.cancel();
    return super.close();
  }
}
