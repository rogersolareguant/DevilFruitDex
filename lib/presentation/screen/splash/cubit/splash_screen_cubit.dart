import 'package:bloc/bloc.dart';
import 'package:devilfruitdex/domain/repository/user_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'splash_screen_state.dart';
part 'splash_screen_cubit.freezed.dart';

class SplashScreenCubit extends Cubit<SplashScreenState> {
  final UserRepository _repository;

  SplashScreenCubit({required UserRepository repository})
      : _repository = repository,
        super(const SplashScreenState());

  Future<void> userLoaded() async {
    emit(state.copyWith(status: SplashScreenStatus.loading));

    try {
      await Future.delayed(const Duration(seconds: 4));

      final user = await _repository.userLoaded();

      if (user != null) {
        emit(state.copyWith(status: SplashScreenStatus.authenticated));
      } else {
        emit(state.copyWith(status: SplashScreenStatus.unauthenticated));
      }
    } catch (e) {
      emit(state.copyWith(status: SplashScreenStatus.error));
    }
  }
}

