import 'package:devilfruitdex/presentation/screen/home/cubit/devil_fruit_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeSearchBar extends StatelessWidget {
  const HomeSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SearchBar(
        leading: Icon(
          Icons.search,
          color: Theme.of(context).iconTheme.color,
        ),
        hintText: AppLocalizations.of(context)!.search,
        hintStyle:
            WidgetStateProperty.all(Theme.of(context).textTheme.headlineSmall),
        textStyle:
            WidgetStateProperty.all(Theme.of(context).textTheme.bodyMedium),
        onChanged: context.read<DevilFruitCubit>().updateSearchFilter);
  }
}

class FavHomeSearchBar extends StatelessWidget {
  const FavHomeSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SearchBar(
        leading: Icon(
          Icons.search,
          color: Theme.of(context).iconTheme.color,
        ),
        hintText: AppLocalizations.of(context)!.search,
        hintStyle:
            WidgetStateProperty.all(Theme.of(context).textTheme.headlineSmall),
        textStyle:
            WidgetStateProperty.all(Theme.of(context).textTheme.bodyMedium),
        onChanged: context.read<DevilFruitCubit>().updateFavSearchFilter);
  }
}
