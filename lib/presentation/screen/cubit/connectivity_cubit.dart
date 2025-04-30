import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

part 'connectivity_state.dart';
part 'connectivity_cubit.freezed.dart';

class ConnectivityCubit extends Cubit<ConnectivityState> {
  final InternetConnectionChecker _connectionChecker;
  late StreamSubscription<InternetConnectionStatus> _connectionSubscription;

  ConnectivityCubit(this._connectionChecker)
      : super(const ConnectivityState(status: ConnectivityStatus.connected)) {
    _startChecking();
  }

  void _startChecking() {
    _connectionSubscription = _connectionChecker.onStatusChange.listen((status) {
      if (status == InternetConnectionStatus.connected) {
        emit(const ConnectivityState(status: ConnectivityStatus.connected));
      } else {
        emit(const ConnectivityState(status: ConnectivityStatus.disconnected));
      }
    });
  }

  @override
  Future<void> close() {
    _connectionSubscription.cancel();
    return super.close();
  }
}
