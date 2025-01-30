part of 'splash_screen_cubit.dart';

enum SplashScreenStatus { loading, authenticated, unauthenticated, error }

@freezed
class SplashScreenState with _$SplashScreenState {
  const factory SplashScreenState({
    @Default(SplashScreenStatus.loading) SplashScreenStatus status,
  }) = _SplashScreenState; 
}
