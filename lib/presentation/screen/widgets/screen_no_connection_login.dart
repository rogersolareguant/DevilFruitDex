import 'package:devilfruitdex/presentation/screen/cubit/connectivity_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

class ScreenNoConnectionLogin extends StatelessWidget {
  const ScreenNoConnectionLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ConnectivityCubit, ConnectivityState>(
      listener: (context, state) {
        if (state.status == ConnectivityStatus.connected) {
          context.go('/login');
        }
      },
      child: Scaffold(
        appBar: AppBar(
            title: Text(AppLocalizations.of(context)!.noConnection,
            style: Theme.of(context).textTheme.titleLarge),
          
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.signal_cellular_connected_no_internet_4_bar,
                  size: 100, color: Theme.of(context).dialogBackgroundColor),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(AppLocalizations.of(context)!.checkNetwork,
                    style: Theme.of(context).textTheme.bodyLarge,
                    textAlign: TextAlign.center,),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
