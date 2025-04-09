import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pizza_ap_admin/src/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:pizza_ap_admin/src/modules/auth/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:pizza_repository/pizza_repository.dart';

import '../modules/auth/views/signin_screen.dart';
import '../modules/base/views/base_screen.dart';
import '../modules/create_pizza/blocs/create_pizza_bloc/create_pizza_bloc.dart';
import '../modules/create_pizza/blocs/upload_picture_bloc/upload_picture_bloc.dart';
import '../modules/create_pizza/views/create_pizza_screen.dart';
import '../modules/home/views/home_screen.dart';
import '../modules/splash/views/splash_screen.dart';

final _navKey = GlobalKey<NavigatorState>();
final _shellNavigationKey = GlobalKey<NavigatorState>();

GoRouter router(AuthenticationBloc authBloc) {
  return GoRouter(
    navigatorKey: _navKey,
    initialLocation: '/',
    redirect: (context, state) {
      if (authBloc.state.status == AuthenticationStatus.unknown) {
        return '/';
      }
      return null;
    },
    routes: [
      ShellRoute(
        navigatorKey: _shellNavigationKey,
        builder: (context, state, child) {
          if (state.fullPath == '/login' || state.fullPath == '/') {
            return child;
          } else {
            return BlocProvider<SignInBloc>(
              create:
                  (context) => SignInBloc(
                    context.read<AuthenticationBloc>().userRepository,
                  ),
              child: SignInScreen(),
            );
          }
        },

        routes: [
          GoRoute(
            path: '/',
            builder:
                (context, state) => BlocProvider<AuthenticationBloc>.value(
                  value: BlocProvider.of<AuthenticationBloc>(context),
                  child: SplashScreen(),
                ),
          ),

          GoRoute(
            path: '/login',
            builder: (context, state) => MultiBlocProvider(
              providers: [
                BlocProvider<AuthenticationBloc>.value(
                  value: BlocProvider.of<AuthenticationBloc>(context),
                ),
                BlocProvider<SignInBloc>(
                  create: (context) => SignInBloc(
                    context.read<AuthenticationBloc>().userRepository,
                  ),
                ),
              ],
              child: SignInScreen(),
            ),
          ),


          GoRoute(path: '/home', builder: (context, state) => HomeScreen()),

          GoRoute(
            path: '/create',
            builder: (context, state) => MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create: (context) => UploadPictureBloc(
                        FirebasePizzaRepo()
                    ),
                  ),
                  BlocProvider(
                    create: (context) => CreatePizzaBloc(
                        FirebasePizzaRepo()
                    ),
                  )
                ],
                child: const CreatePizzaScreen()),
          ),
        ],
      ),
    ],
  );
}
