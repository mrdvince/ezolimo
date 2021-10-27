import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/constants/strings.dart';
import '../../../../logic/predict/predict_cubit.dart';

class PredictWidget extends StatelessWidget {
  final PredictCubit cubit;

  const PredictWidget({Key? key, required this.cubit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (cubit.state is PredictLoadingState) {
      return const Center(child: CircularProgressIndicator());
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

    return BlocListener<PredictCubit, PredictState>(
      listener: (context, state) {
        if (state is ImageSelectedState) {
          cubit.objDetectImage(cubit.state.imageFile);
        }
      },
      // ignore: deprecated_member_use
      child: FlatButton(
        height: 60,
        minWidth: MediaQuery.of(context).size.width * 0.75,
        onPressed: () {
          _openImagePicker(context, cubit);
        },
        child: const Text(
          'Choose an image',
          style: TextStyle(color: Colors.white),
        ),
        color: const Color(0xFFc77800),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
      ),
    );
  }
}
