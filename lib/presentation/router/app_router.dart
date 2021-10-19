import 'package:ezolimo/logic/predict/predict_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/exceptions/route_exception.dart';
import '../screens/home_screen/home_screen.dart';
import '../screens/sign_in_screen/sign_in_screen.dart';

class AppRouter {
  static const String home = '/';
  static const String signin = 'signin';

  const AppRouter._();

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => PredictCubit(),
            child: const HomeScreen(),
          ),
        );
      case signin:
        return MaterialPageRoute(
          builder: (_) => const SignInScreen(),
        );
      default:
        throw const RouteException('Route not found!');
    }
  }
}
