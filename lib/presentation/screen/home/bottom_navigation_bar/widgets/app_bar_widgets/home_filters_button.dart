import 'package:devilfruitdex/presentation/screen/home/cubit/devil_fruit_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeSortButton extends StatelessWidget {
  const HomeSortButton({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      icon: Icon(Icons.sort_rounded,
          color: Theme.of(context).primaryIconTheme.color),
      itemBuilder: (BuildContext context) => [
        PopupMenuItem(
          child: const Text('Id'),
          onTap: () {
            context.read<DevilFruitCubit>().updateSortByFilter('id');
          },
        ),
        PopupMenuItem(
          child: Text(AppLocalizations.of(context)!.name),
          onTap: () {
            context.read<DevilFruitCubit>().updateSortByFilter('name');
          },
        ),
      ],
      onSelected: (value) {},
    );
  }
}

class HomeTypeFilterButton extends StatelessWidget {
  const HomeTypeFilterButton({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      icon: Icon(Icons.filter_5_rounded,
          color: Theme.of(context).primaryIconTheme.color),
      itemBuilder: (BuildContext context) => [
        PopupMenuItem(
          child: Text(AppLocalizations.of(context)!.none),
          onTap: () {
            context.read<DevilFruitCubit>().updateTypeFilter('None');
          },
        ),
        PopupMenuItem(
          child: const Text('Paramecia'),
          onTap: () {
            context.read<DevilFruitCubit>().updateTypeFilter('Paramecia');
          },
        ),
        PopupMenuItem(
          child: const Text('Logia'),
          onTap: () {
            context.read<DevilFruitCubit>().updateTypeFilter('Logia');
          },
        ),
        PopupMenuItem(
          child: const Text('Zoan'),
          onTap: () {
            context.read<DevilFruitCubit>().updateTypeFilter('Zoan');
          },
        ),
        PopupMenuItem(
          child: const Text('Smile'),
          onTap: () {
            context.read<DevilFruitCubit>().updateTypeFilter('Smile');
          },
        ),
      ],
    );
  }
}

class FavHomeSortButton extends StatelessWidget {
  const FavHomeSortButton({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      icon: Icon(Icons.sort_rounded,
          color: Theme.of(context).primaryIconTheme.color),
      itemBuilder: (BuildContext context) => [
        PopupMenuItem(
          child: const Text('Id'),
          onTap: () {
            context.read<DevilFruitCubit>().updateFavSortByFilter('id');
          },
        ),
        PopupMenuItem(
          child: Text(AppLocalizations.of(context)!.name),
          onTap: () {
            context.read<DevilFruitCubit>().updateFavSortByFilter('name');
          },
        ),
      ],
      onSelected: (value) {},
    );
  }
}

class FavHomeTypeFilterButton extends StatelessWidget {
  const FavHomeTypeFilterButton({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      icon: Icon(Icons.filter_5_rounded,
          color: Theme.of(context).primaryIconTheme.color),
      itemBuilder: (BuildContext context) => [
        PopupMenuItem(
          child: Text(AppLocalizations.of(context)!.none),
          onTap: () {
            context.read<DevilFruitCubit>().updateFavTypeFilter('None');
          },
        ),
        PopupMenuItem(
          child: const Text('Paramecia'),
          onTap: () {
            context.read<DevilFruitCubit>().updateFavTypeFilter('Paramecia');
          },
        ),
        PopupMenuItem(
          child: const Text('Logia'),
          onTap: () {
            context.read<DevilFruitCubit>().updateFavTypeFilter('Logia');
          },
        ),
        PopupMenuItem(
          child: const Text('Zoan'),
          onTap: () {
            context.read<DevilFruitCubit>().updateFavTypeFilter('Zoan');
          },
        ),
        PopupMenuItem(
          child: const Text('Smile'),
          onTap: () {
            context.read<DevilFruitCubit>().updateFavTypeFilter('Smile');
          },
        ),
      ],
    );
  }
}
