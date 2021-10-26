import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/strings.dart';
import '../../../logic/auth/auth_cubit.dart';
import '../../../logic/predict/predict_cubit.dart';
import '../../../logic/storage.dart';
import '../sign_in_screen/sign_in_screen.dart';
import 'widgets/before_predict_widget.dart';
import 'widgets/fetch_predictions_widget.dart';

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
    context.watch<AuthCubit>();
    final cubit = context.watch<PredictCubit>();
    return Scaffold(
      body: FutureBuilder(
          future: _checkToken,
          builder: (context, snapshot) {
            if (!snapshot.hasData) return const CircularProgressIndicator();
            if (snapshot.data != "") {
              return Scaffold(
                backgroundColor: Colors.blueGrey.shade50,
                appBar: _appBar(cubit),
                body: cubit.state is PredictDoneState
                    ? fetchPredictions(cubit, context)
                    : BeforePredict(
                        predictCubit: cubit,
                      ),
              );
            }
            return const SignInScreen();
          }),
    );
  }

  AppBar _appBar(PredictCubit cubit) {
    return AppBar(
      title: Text(Strings.appTitle),
      actions: [
        cubit.state is PredictDoneState
            ? IconButton(
                onPressed: () {
                  cubit.emit(PredictInitial());
                },
                icon: const Icon(Icons.replay))
            : IconButton(
                onPressed: () {
                  clearToken();
                },
                icon: const Icon(Icons.logout_outlined))
      ],
    );
  }

  void clearToken() {
    BlocProvider.of<AuthCubit>(context).logOut();
  }
}
