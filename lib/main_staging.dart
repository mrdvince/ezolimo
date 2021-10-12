import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/constants/strings.dart';
import 'core/themes/app_theme.dart';
import 'domain/debug/app_bloc_observer.dart';
import 'presentation/features/auth/auth_bloc.dart';
import 'presentation/router/app_router.dart';

void main() {
  Bloc.observer = AppBlocObserver();
  runApp(App(
    authenticationBloc: AuthBloc(),
  ));
}

class App extends StatelessWidget {
  final AuthBloc authenticationBloc;
  const App({
    Key? key,
    required this.authenticationBloc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(create: (context) => AuthBloc()),
      ],
      child: MaterialApp(
        title: Strings.appTitle,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        debugShowCheckedModeBanner: false,
        initialRoute: AppRouter.home,
        onGenerateRoute: AppRouter.onGenerateRoute,
      ),
    );
  }
}
