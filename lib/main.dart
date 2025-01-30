import 'dart:io';

import 'package:devilfruitdex/data/repository/devil_fruit_repository_impl.dart';
import 'package:devilfruitdex/data/repository/authentication_repository_impl.dart';
import 'package:devilfruitdex/data/repository/favourites_repository_impl.dart';
import 'package:devilfruitdex/data/repository/location_repository_impl.dart';
import 'package:devilfruitdex/domain/repository/devil_fruit_repository.dart';
import 'package:devilfruitdex/domain/repository/authentication_repository.dart';
import 'package:devilfruitdex/domain/repository/favourites_repository.dart';
import 'package:devilfruitdex/domain/repository/location_repository.dart';
import 'package:devilfruitdex/firebase_options.dart';
import 'package:devilfruitdex/presentation/navigation/route.dart';
import 'package:devilfruitdex/presentation/screen/home/bottom_navigation_bar/views/settings/cubit/settings_cubit.dart';
import 'package:devilfruitdex/presentation/screen/home/cubit/devil_fruit_cubit.dart';
import 'package:devilfruitdex/presentation/screen/splash/cubit/splash_screen_cubit.dart';
import 'package:devilfruitdex/presentation/style/app_theme.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

Future<void> main() async {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final user = FirebaseAuth.instance.currentUser;

  runApp(MainApp(currentUser: user));
}

class MainApp extends StatelessWidget {
  final User? currentUser;

  const MainApp({super.key, required this.currentUser});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<DevilFruitRepository>(
          create: (context) => DevilFruitRepositoryImpl(dio: Dio()),
        ),
        RepositoryProvider<AuthenticationRepository>(
          create: (context) =>
              AuthenticationRepositoryImpl(firebaseAuth: FirebaseAuth.instance),
        ),
        RepositoryProvider<FavouritesRepository>(
          create: (context) =>
              FavouritesRepositoryImpl(firebaseAuth: FirebaseAuth.instance),
        ),
        RepositoryProvider<LocationRepository>(
          create: (context) =>
              LocationRepositoryImpl(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => SettingsCubit(),
          ),
          BlocProvider(
            create: (context) => SplashScreenCubit(
                repository: context.read<AuthenticationRepository>()),
          ),
          if (currentUser == null) 
            BlocProvider(
              create: (context) => DevilFruitCubit(
                repository: context.read<DevilFruitRepository>(), 
                favRepository: context.read<FavouritesRepository>(), 
                locationRepository: context.read<LocationRepository>(),
                uid: currentUser!.uid
              ),
            )
          
        ],
        child: BlocBuilder<SettingsCubit, SettingsState>(
          builder: (context, state) {
            return MaterialApp.router(
              theme: AppTheme.standard,
              darkTheme: AppTheme.dark,
              themeMode: state.darkMode ? ThemeMode.dark : ThemeMode.light,
              title: 'Devildex App',
              locale: state.language,
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: const [
                Locale('en'),
                Locale('es'),
              ],
              debugShowCheckedModeBanner: false,
              routerConfig: appRouter,
            );
          },
        ),
      ),
    );
  }
}
