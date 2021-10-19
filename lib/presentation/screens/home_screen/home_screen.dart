import 'dart:io';

import '../../../core/constants/strings.dart';
import '../../../logic/predict/predict_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../logic/auth/auth_cubit.dart';
import '../../router/app_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<AuthCubit>();

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
              title: Text(Strings.appTitle),
              actions: [
                IconButton(
                    onPressed: () {
                      clearToken(cubit);
                    },
                    icon: const Icon(Icons.logout_outlined))
              ],
            ),
            body: const Camera());
      },
    );
  }

  void clearToken(
    cubit,
  ) {
    // BlocProvider.of<AuthCubit>(context).logOut();
    cubit.logOut();
  }
}

class Camera extends StatefulWidget {
  const Camera({Key? key}) : super(key: key);

  @override
  State<Camera> createState() => _CameraState();
}

class _CameraState extends State<Camera> {
  void _openImagePicker(BuildContext context, PredictCubit cubit) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 150.0,
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Text(
                  Strings.pickImage,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                TextButton(
                    onPressed: () {
                      cubit.getImage(source: ImageSource.camera);
                      Navigator.pop(context);
                    },
                    child: Text(Strings.useCamera)),
                TextButton(
                    onPressed: () {
                      cubit.getImage(source: ImageSource.gallery);
                      Navigator.pop(context);
                    },
                    child: Text(Strings.useGallery))
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<PredictCubit>();
    return Column(
      children: [
        const SizedBox(height: 10.0),
        cubit.state.imageFile == null
            ? const Icon(Icons.ac_unit)
            : Image.file(
                File(cubit.state.imageFile.toString()),
                fit: BoxFit.cover,
                height: 300.0,
                width: MediaQuery.of(context).size.width,
              ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            OutlinedButton(
              onPressed: () {
                _openImagePicker(context, cubit);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.camera_alt),
                  const SizedBox(
                    width: 5.0,
                  ),
                  Text(Strings.pickImage)
                ],
              ),
            ),
            OutlinedButton(
                onPressed: () {
                  cubit.objDetectImage(cubit.state.imageFile);
                },
                child: Row(
                  children: [
                    const Icon(Icons.precision_manufacturing),
                    const SizedBox(
                      width: 5.0,
                    ),
                    Text(Strings.predict),
                  ],
                ))
          ],
        ),
      ],
    );
  }
}
