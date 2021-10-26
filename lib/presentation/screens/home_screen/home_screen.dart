import '../../../logic/storage.dart';
import '../sign_in_screen/sign_in_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<String> get _checkToken async {
    var jwt = await Storage().secureStorage.read(key: 'access_token');
    if (jwt == null) return "";
    return jwt;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: _checkToken,
          builder: (context, snapshot) {
            if (!snapshot.hasData) return const CircularProgressIndicator();
            if (snapshot.data != "") {
              return const Scaffold(
                backgroundColor: Colors.green,
              );
            }
            return const SignInScreen();
          }),
    );
  }
}
