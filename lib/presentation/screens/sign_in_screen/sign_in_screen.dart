// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
// ignore: implementation_imports
import 'package:provider/src/provider.dart';

import 'package:ezolimo/core/constants/strings.dart';
import 'package:ezolimo/logic/auth/auth_cubit.dart';
import 'package:ezolimo/logic/validator.dart';
import 'package:ezolimo/presentation/router/app_router.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final cubit = context.watch<AuthCubit>();

    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is Authenticated) {
          Navigator.of(context).pushNamedAndRemoveUntil(
              AppRouter.home, (Route<dynamic> route) => false);
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              logo(mq),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(36.0),
                  decoration: const BoxDecoration(
                    color: Color(0xff1b5e20),
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(30),
                    ),
                  ),
                  child: Form(
                    key: _formKey,
                    autovalidate: false,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          headerText(context),
                          fields(context),
                          bottom(mq, context, cubit)
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Align headerText(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Text(
        Strings.login,
        style: GoogleFonts.lato(
            textStyle: Theme.of(context).textTheme.headline4,
            fontSize: 48,
            fontWeight: FontWeight.w700,
            fontStyle: FontStyle.italic,
            color: Colors.white),
      ),
    );
  }

  Column bottom(MediaQueryData mq, BuildContext context, cubit) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        loginButton(mq, cubit),
        const Padding(
          padding: EdgeInsets.all(8.0),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              Strings.notRegistered,
              style: Theme.of(context).textTheme.subtitle1?.copyWith(
                    color: Colors.white,
                  ),
            ),
            MaterialButton(
              onPressed: () {},
              child: Text(
                Strings.signup,
                style: Theme.of(context).textTheme.subtitle1?.copyWith(
                      color: Colors.white,
                      decoration: TextDecoration.underline,
                    ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  ButtonTheme loginButton(MediaQueryData mq, AuthCubit cubit) {
    return ButtonTheme(
      minWidth: mq.size.width / 1.2,
      height: 50.0,
      child: FlatButton(
        onPressed: () async {
          // login
          // navigate
          if (cubit.state is Authenticated) {
            Navigator.of(context).pushNamedAndRemoveUntil(
                AppRouter.home, (Route<dynamic> route) => false);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(Strings.notLoggedIn),
              ),
            );
            if (_formKey.currentState!.validate()) {
              cubit.authenticate(_emailController.text.trim(),
                  _passwordController.text.trim());
            }
          }
        },
        child: Text(
          Strings.login,
          style: const TextStyle(color: Colors.white),
        ),
        color: const Color(0xFFc77800),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }

  Padding fields(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[emailField(), passwordField(context)],
      ),
    );
  }

  Column passwordField(BuildContext context) {
    return Column(
      children: <Widget>[
        TextFormField(
          validator: Validator.validatePassword,
          obscureText: true,
          controller: _passwordController,
          style: const TextStyle(
            color: Colors.white,
          ),
          cursorColor: Colors.white,
          decoration: const InputDecoration(
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.white,
              ),
            ),
            hintText: "password",
            labelText: "Password",
            labelStyle: TextStyle(
              color: Colors.white,
            ),
            hintStyle: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(2.0),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            MaterialButton(
                child: Text(
                  Strings.forgotPassword,
                  style: Theme.of(context)
                      .textTheme
                      .caption
                      ?.copyWith(color: Colors.white),
                ),
                onPressed: () {}),
          ],
        ),
      ],
    );
  }

  TextFormField emailField() {
    return TextFormField(
      validator: Validator.validateEmail,
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      style: const TextStyle(
        color: Colors.white,
      ),
      cursorColor: Colors.white,
      decoration: const InputDecoration(
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
        hintText: "something@example.com",
        labelText: "Email",
        labelStyle: TextStyle(
          color: Colors.white,
        ),
        hintStyle: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }

  Image logo(MediaQueryData mq) {
    return Image.asset(
      'assets/logo/logo.png',
      color: Colors.green.shade900,
      height: mq.size.height / 3,
    );
  }
}
