import 'package:devilfruitdex/presentation/screen/cubit/connectivity_cubit.dart';
import 'package:devilfruitdex/presentation/screen/home/bottom_navigation_bar/views/map/map_view.dart';
import 'package:devilfruitdex/presentation/screen/home/bottom_navigation_bar/views/favourite_fruits/fav_view.dart';
import 'package:devilfruitdex/presentation/screen/home/bottom_navigation_bar/views/all_fruits/home_view.dart';
import 'package:devilfruitdex/presentation/screen/home/bottom_navigation_bar/views/settings/settings_view_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_lazy_indexed_stack/flutter_lazy_indexed_stack.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class HomeBottomNavigationBar extends StatefulWidget {
  const HomeBottomNavigationBar({
    super.key,
  });

  @override
  State<HomeBottomNavigationBar> createState() =>
      _HomeBottomNavigationBarState();
}

class _HomeBottomNavigationBarState extends State<HomeBottomNavigationBar>
    with WidgetsBindingObserver {
  int _selectedIndex = 2;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(AppLocalizations.of(context)!.welcomeBack,
                style: Theme.of(context).textTheme.displayMedium,
                textAlign: TextAlign.center),
            backgroundColor: Theme.of(context).cardColor),
      );
    }
  }

  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ConnectivityCubit, ConnectivityState>(
      listener: (context, state) {
        if (state.status == ConnectivityStatus.disconnected) {
          context.go('/no-connection');
        }
      },
      child: Scaffold(
        body: LazyIndexedStack(
          index: _selectedIndex,
          children: [
            const MapView(),
            const FavView(),
            const HomeView(),
            const SettingsScreenProvider(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.shifting,
          currentIndex: _selectedIndex,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          onTap: _onItemTap,
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.map_outlined,
                color: Theme.of(context).primaryIconTheme.color,
              ),
              activeIcon: Icon(
                Icons.map,
                color: Theme.of(context).primaryIconTheme.color,
              ),
              label: '',
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.favorite_outline,
                color: Theme.of(context).primaryIconTheme.color,
              ),
              activeIcon: Icon(
                Icons.favorite,
                color: Theme.of(context).primaryIconTheme.color,
              ),
              label: '',
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home_outlined,
                color: Theme.of(context).primaryIconTheme.color,
              ),
              activeIcon: Icon(
                Icons.home,
                color: Theme.of(context).primaryIconTheme.color,
              ),
              label: '',
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.settings_outlined,
                color: Theme.of(context).primaryIconTheme.color,
              ),
              activeIcon: Icon(
                Icons.settings,
                color: Theme.of(context).primaryIconTheme.color,
              ),
              label: '',
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            ),
          ],
        ),
      ),
    );
  }
}
