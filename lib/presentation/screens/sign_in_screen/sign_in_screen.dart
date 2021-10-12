import '../../../data/http/http_client.dart';
import '../../../domain/storage.dart';
import '../../router/app_router.dart';
import 'package:flutter/material.dart';

import 'widgets/email_password.dart';
import 'widgets/with_socials.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  String message = '';
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topCenter, colors: [
          Colors.green.shade900,
          Colors.green.shade800,
          Colors.green.shade400
        ])),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(
              height: 80,
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const <Widget>[
                  Text(
                    "Login",
                    style: TextStyle(color: Colors.white, fontSize: 40),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Welcome Back",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(60),
                        topRight: Radius.circular(60))),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(30),
                    child: Column(
                      children: <Widget>[
                        const SizedBox(
                          height: 60,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: const [
                                BoxShadow(
                                    color: Color.fromRGBO(225, 95, 27, .3),
                                    blurRadius: 20,
                                    offset: Offset(0, 10))
                              ]),
                          child: EmailPassword(
                              formKey: _formKey,
                              emailController: emailController,
                              passwordController: passwordController),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        const Text(
                          "Forgot Password?",
                          style: TextStyle(color: Colors.grey),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Container(
                          height: 50,
                          margin: const EdgeInsets.symmetric(horizontal: 50),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.green.shade900),
                          child: Center(
                            child: TextButton(
                              child: const Text("Login",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)),
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  var email =
                                      emailController.text.replaceAll(' ', '');
                                  var password = passwordController.text;
                                  var rsp = await getAuthTokenReq(
                                      email: email, password: password);
                                  if (rsp.toString().contains('access_token')) {
                                    // store token
                                    String token = rsp['access_token'];
                                    Storage().secureStorage.write(
                                        key: 'access_token', value: token);
                                    Navigator.pushNamedAndRemoveUntil(context,
                                        AppRouter.home, (route) => false);
                                  }
                                }
                              },
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        const Text(
                          "Continue with social media",
                          style: TextStyle(color: Colors.grey),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        const ContinueWithSocials()
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
