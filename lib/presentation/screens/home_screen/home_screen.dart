import 'dart:io';

import 'package:ezolimo/core/constants/urls.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/constants/strings.dart';
import '../../../logic/auth/auth_cubit.dart';
import '../../../logic/predict/predict_cubit.dart';
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
  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<PredictCubit>();
    if (cubit.state is PredictLoadingState) {
      return const Center(child: CircularProgressIndicator());
    }
    return cubit.state is PredictDoneState
        ? predMethod(cubit, context)
        : defaultMethod(cubit, context);
  }

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

  Column defaultMethod(PredictCubit cubit, BuildContext context) {
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

  Column predMethod(PredictCubit cubit, context) {
    var _predictions = cubit.state.preds;

    Expanded _buildImageCrops(int count, context) {
      return Expanded(
        child: ListView.builder(
          padding: const EdgeInsets.only(top: 10, bottom: 15),
          itemCount: count,
          itemBuilder: (BuildContext contex, int index) {
            var _url = _predictions!.imageCrops[index];
            return Image.network('${ServerUrls.baseUrl}/$_url');
          },
        ),
      );
    }

    return Column(
      children: [
        Image.network(
          '${ServerUrls.baseUrl}/${_predictions!.path}/${_predictions.filename}',
          fit: BoxFit.cover,
          height: 300.0,
          width: MediaQuery.of(context).size.width,
        ),
        _buildImageCrops(_predictions.imageCrops.length, context),
      ],
    );
  }
}
