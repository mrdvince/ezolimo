import 'package:ezolimo/config/routes.dart';
import 'package:ezolimo/config/theme.dart';
import 'package:ezolimo/domain/entities/validator.dart';
import 'package:ezolimo/presentantion/feautures/sign_in/sign_in_bloc.dart';
import 'package:ezolimo/presentantion/widgets/independent/block_header.dart';
import 'package:ezolimo/presentantion/widgets/independent/right_arrow_action.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../widgets/independent/input_field.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<OpenFlutterInputFieldState> emailKey = GlobalKey();
  final GlobalKey<OpenFlutterInputFieldState> passwordKey = GlobalKey();

  late double sizeBetween;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    sizeBetween = height / 20;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.transparent,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        elevation: 0,
        iconTheme: IconThemeData(color: AppColors.black),
      ),
      backgroundColor: AppColors.background,
      body: BlocConsumer<SignInBloc, SignInState>(
        listener: (context, state) {
          // on success delete navigator stack and push to home
          if (state is SignInFinishedState) {
            Navigator.of(context).pushNamedAndRemoveUntil(
              EzoRoutes.home,
              (Route<dynamic> route) => false,
            );
          }
          // on failure show a snackbar
          if (state is SignInErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
                backgroundColor: Colors.red,
                duration: Duration(seconds: 3),
              ),
            );
          }
        },
        builder: (context, state) {
          // show loading screen while processing
          if (state is SignInProcessingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return SingleChildScrollView(
            child: Container(
              height: height * 0.9,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  OpenFlutterBlockHeader(title: 'Sign in', width: width),
                  SizedBox(
                    height: sizeBetween,
                  ),
                  OpenFlutterInputField(
                    key: emailKey,
                    controller: emailController,
                    hint: 'Email',
                    validator: Validator.validateEmail,
                    keyboard: TextInputType.emailAddress,
                  ),
                  OpenFlutterInputField(
                    key: passwordKey,
                    controller: passwordController,
                    hint: 'Password',
                    validator: Validator.passwordCorrect,
                    keyboard: TextInputType.visiblePassword,
                    isPassword: true,
                  ),
                  // ignore: lines_longer_than_80_chars
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: GestureDetector(
                      onTap: () async {
                        await Navigator.of(context)
                            .pushNamed(EzoRoutes.forgotPassword);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: const [
                          Text('Forgot your password'),
                          Icon(
                            Icons.trending_flat,
                            color: AppColors.red,
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: InkWell(
                      onTap: () => {},
                      child: Container(
                        width: width,
                        height: height,
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                        decoration: BoxDecoration(
                            color: AppColors.red,
                            border: Border.all(color: AppColors.red),
                            borderRadius:
                                BorderRadius.circular(AppSizes.buttonRadius),
                            boxShadow: [
                              BoxShadow(
                                  color: AppColors.red.withOpacity(0.3),
                                  blurRadius: 4.0,
                                  offset: Offset(0.0, 5.0)),
                            ]),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(),
                              Text(
                                'LOGIN',
                                style: TextStyle(
                                  backgroundColor: AppColors.background,
                                  color: AppColors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: sizeBetween * 2,
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: AppSizes.linePadding),
                    child: Center(
                      child: Text('Or sign up with social account'),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

//   void _validateAndSend() {
//     if (emailKey.currentState.validate() != null) {
//       return;
//     }
//     if (passwordKey.currentState.validate() != null) {
//       return;
//     }
//     BlocProvider.of<SignInBloc>(context).add(
//       SignInPressed(
//         email: emailController.text,
//         password: passwordController.text,
//       ),
//     );
//   }
// }
