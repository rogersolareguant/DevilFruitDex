import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class ScreenSuccessChangePassword extends StatefulWidget {
  const ScreenSuccessChangePassword({super.key});

  @override
  State<ScreenSuccessChangePassword> createState() => _ScreenSuccessChangePasswordState();
}

class _ScreenSuccessChangePasswordState extends State<ScreenSuccessChangePassword> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        context.go('/home');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.check_circle, color: Theme.of(context).primaryIconTheme.color, size: 80),
            const SizedBox(height: 20),
            Text(
              AppLocalizations.of(context)!.changedSucces,
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ],
        ),
      ),
    );
  }
}
