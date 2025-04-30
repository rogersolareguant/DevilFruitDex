part of 'connectivity_cubit.dart';

enum ConnectivityStatus { initial, connected, disconnected }

@freezed
class ConnectivityState with _$ConnectivityState {
  const ConnectivityState._(); 

  const factory ConnectivityState({
    @Default(ConnectivityStatus.initial) ConnectivityStatus status,
  }) = _ConnectivityState;
}
