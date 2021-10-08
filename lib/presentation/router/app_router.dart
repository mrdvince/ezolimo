import 'package:ezolimo/presentation/screens/sign_in_screen/sign_in_screen.dart';
import 'package:flutter/material.dart';

import '../../core/constants/strings.dart';
import '../../core/exceptions/route_exception.dart';
import '../screens/home_screen/home_screen.dart';

class AppRouter {
  static const String home = '/';
  static const String signin = 'signin';

  const AppRouter._();

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(
          builder: (_) => HomeScreen(
            title: Strings.homeScreenTitle,
          ),
        );
      case signin:
        return MaterialPageRoute(
          builder: (_) => SignInScreen(),
        );
      default:
        throw const RouteException('Route not found!');
    }
  }
}
