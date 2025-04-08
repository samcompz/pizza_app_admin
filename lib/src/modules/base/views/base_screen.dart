import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../auth/blocs/sign_in_bloc/sign_in_bloc.dart';

class BaseScreen extends StatelessWidget {
  const BaseScreen(Widget child, {super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      listener: (BuildContext context, state) {
        if (state is SignOutRequired) {
          // html.window.location.reload();
        }
      },
      child: Scaffold(
        body: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: kToolbarHeight,
              color: Colors.red,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    //inkwell button to - home
                    InkWell(
                      onTap: () {
                        context.go('/home');
                      },
                      child: Text(
                        'Pizza Admin',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    SizedBox(width: 30),
                    //another inkwell - button to
                    InkWell(
                      onTap: () {
                        context.go('/home');
                      },
                      child: Text(
                        'Create Pizza',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.grey,
                          // fontSize: 20
                        ),
                      ),
                    ),

                    //Inkwell - logout
                    InkWell(
                      onTap: () {
                        context.read<SignInBloc>().add(SignOutRequired());
                      },
                      splashColor: Colors.red,
                      child: Row(
                        children: [
                          Text(
                            'Logout',
                            style: TextStyle(
                              // fontWeight: FontWeight.w600,
                              color: Colors.grey,
                              // fontSize: 20
                            ),
                          ),
                          SizedBox(width: 5),
                          Icon(CupertinoIcons.arrow_right_to_line),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
                child: widget.child
            ),
          ],
        ),
      ),
    );
  }
}
