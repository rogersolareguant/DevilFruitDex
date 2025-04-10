import 'package:devilfruitdex/presentation/screen/home/bottom_navigation_bar/views/map/eat_fruit/eat_fruit_provider.dart';
import 'package:devilfruitdex/presentation/screen/home/bottom_navigation_bar/views/settings/change_password/change_password_provider.dart';
import 'package:devilfruitdex/presentation/screen/home/detail/detail_screen_provider.dart';
import 'package:devilfruitdex/presentation/screen/home/bottom_navigation_bar/home_screen_provider.dart';
import 'package:devilfruitdex/presentation/screen/login/create_user/create_user_screen_provider.dart';
import 'package:devilfruitdex/presentation/screen/login/login/login_screen_provider.dart';
import 'package:devilfruitdex/presentation/screen/splash/splash_screen.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(routes: [
  GoRoute(
    path: '/',
    builder: (context, state) => const SplashScreen(),
  ),
  GoRoute(
    path: '/login',
    builder: (context, state) => const LoginScreenProvider(),
    routes: [
      GoRoute(
        path: 'createuser',
        builder: (context, state) => const CreateUserScreenProvider(),
      ),
    ],
  ),
  GoRoute(
      path: '/home',
      builder: (context, state) => const HomeScreenProvider(),
      routes: [
        GoRoute(
          path: 'detail/:id',
          builder: (context, state) {
            String id = state.pathParameters['id']!;
            return DetailScreenProvider(id: id);
          },
        ),
        GoRoute(
          path: 'eat/:id',
          builder: (context, state) {
            String id = state.pathParameters['id']!;
            return EatFruitProvider(id: id);
          },
        ),
        GoRoute(
          path: 'changepassword',
          builder: (context, state) => const ChangePasswordProvider(),
        ),
      ]),
]);
