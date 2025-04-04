import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:devilfruitdex/presentation/screen/splash/cubit/splash_screen_cubit.dart';
import 'package:devilfruitdex/presentation/screen/widgets/screen_error_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _spinController;
  late final AnimationController _fadeController;
  final AudioPlayer _player = AudioPlayer();

  @override
  void initState() {
    super.initState();

    _spinController = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    );

    _spinController.forward();

    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    );

    _fadeController.forward();

    _playSound();

    context.read<SplashScreenCubit>().userLoaded();
  }

  Future<void> _playSound() async {
    await _player.setVolume(1.0);
    await _player.play(AssetSource('sounds/intro.mp3'));
  }

  @override
  void dispose() {
    _spinController.dispose();
    _fadeController.dispose();
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<SplashScreenCubit, SplashScreenState>(
          listener: (context, state) {
        if (state.status == SplashScreenStatus.authenticated) {
          context.go('/home');
        } else if (state.status == SplashScreenStatus.unauthenticated) {
          context.go('/login');
        }
      }, builder: (context, state) {
        if (state.status == SplashScreenStatus.error) {
          return const ScreenErrorState();
        }

        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedBuilder(
                animation: _spinController,
                builder: (context, child) {
                  return Transform.rotate(
                    angle: _spinController.value * 2 * pi,
                    child: SizedBox(
                      height: 200,
                      width: 200,
                      child: Image.asset(
                        'assets/images/farmer-hat.png',
                      ),
                    ),
                  );
                },
              ),
              FadeTransition(
                opacity: _fadeController,
                child: Text(
                  'DEVILDEX',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
