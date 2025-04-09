import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pizza_ap_admin/src/blocs/authentication_bloc/authentication_bloc.dart';

import '../../auth/views/signin_screen.dart';
import '../../home/views/home_screen.dart';


class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: BlocListener<AuthenticationBloc, AuthenticationState>(
        listenWhen: (previous, current) =>
        previous.status != current.status,
        listener: (context, state) {
          if (state.status == AuthenticationStatus.authenticated) {
            context.go('/home');
          } else if (state.status == AuthenticationStatus.unauthenticated) {
            context.go('/login');
          }
        },
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}


