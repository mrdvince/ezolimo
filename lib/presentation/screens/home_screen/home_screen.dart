import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../logic/auth/auth_cubit.dart';
import '../../router/app_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<AuthCubit>(context).isAuthenticated();

    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is Unauthenticated) {
          Navigator.pushNamedAndRemoveUntil(
              context, AppRouter.signin, (route) => false);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Nebos'),
            actions: [
              IconButton(
                  onPressed: () {
                    clearToken(context);
                  },
                  icon: const Icon(Icons.logout_outlined))
            ],
          ),
          body: const Center(
            child: Text('camera'),
          ),
        );
      },
    );
  }

  void clearToken(
    BuildContext context,
  ) {
    BlocProvider.of<AuthCubit>(context).logOut();
  }
}
