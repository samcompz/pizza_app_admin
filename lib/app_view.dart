import 'package:flutter/material.dart';
import 'package:pizza_ap_admin/src/blocs/authentication_bloc/authentication_bloc.dart';

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: "Pizza Admin",
      theme: ThemeData(
        colorScheme: ColorScheme.light(
          background: Colors.grey.shade200,
          onBackground: Colors.black,
          primary: Colors.blue,
          onPrimary: Colors.white,
        )
      ),
      routerConfig: router(context).read<AuthenticationBloc>()
    );
  }
}
