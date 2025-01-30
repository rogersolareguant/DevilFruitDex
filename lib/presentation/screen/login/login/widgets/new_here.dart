import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

class NewHere extends StatelessWidget {
  const NewHere({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          AppLocalizations.of(context)!.newHere,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        TextButton(
          onPressed: () {
            context.go('/login/createuser');
          },
          child: Text(AppLocalizations.of(context)!.register,
              style: Theme.of(context).textTheme.bodyMedium),
        )
      ],
    );
  }
}
