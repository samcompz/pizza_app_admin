import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pizza_ap_admin/src/blocs/authentication_bloc/authentication_bloc.dart';

import '../modules/auth/views/login_screen.dart';
import '../modules/base/views/base_screen.dart';
import '../modules/home/views/home_screen.dart';
import '../modules/splash/views/splash_screen.dart';


final _navKey = GlobalKey<NavigatorState>();
final _shellNavigationKey = GlobalKey<NavigatorState>();

GoRouter router(AuthenticationBloc authBloc){
  return GoRouter(
    navigatorKey: _navKey,
      initialLocation: '/',
      redirect: (context, state){
        if(authBloc.state.status == AuthenticationStatus.unknown){
          return '/';
        }
      },
      routes: [
        ShellRoute(
          navigatorKey: _shellNavigationKey,
            builder: (context, state, child){
               if(state.fullPath == '/login' || state.fullPath == '/'){
                 return child;
               }else{
                 return BaseScreen(child);
               }
            },
            routes: [
              GoRoute(
                  path: '/',
                builder: (context, state) => BlocProvider<AuthenticationBloc>.value(
                  value: BlocProvider.of<AuthenticationBloc>(context),
                    child: SplashScreen(),
                )
              ),

              GoRoute(
                  path: '/login',
                  builder: (context, state) => BlocProvider<AuthenticationBloc>.value(
                    value: BlocProvider.of<AuthenticationBloc>(context),
                    child: LoginScreen(),
                  )
              ),

              GoRoute(
                  path: '/home',
                  builder: (context, state) => BlocProvider<AuthenticationBloc>.value(
                    value: BlocProvider.of<AuthenticationBloc>(context),
                    child: HomeScreen(),
                  )
              ),
            ]
        )
      ]
  );
}