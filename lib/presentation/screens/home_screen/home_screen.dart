import '../../../domain/storage.dart';
import '../sign_in_screen/sign_in_screen.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/strings.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  Future<String> get jwtOrEmpty async {
    var jwt = await Storage().secureStorage.read(key: 'access_token') ?? '';
    return jwt;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Authentication Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FutureBuilder(
          future: jwtOrEmpty,
          builder: (context, snapshot) {
            if (!snapshot.hasData) return const CircularProgressIndicator();
            if (snapshot.data != "") {
              var str = snapshot.data;
              return Scaffold(
                  body: Center(
                child: Text(snapshot.data as String),
              ));
            } else {
              return const SignInScreen();
            }
          }),
    );
  }
}
