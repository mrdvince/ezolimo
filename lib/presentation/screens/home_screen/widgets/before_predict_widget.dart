import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../logic/predict/predict_cubit.dart';
import 'predict_widget.dart';

class BeforePredict extends StatelessWidget {
  final PredictCubit predictCubit;

  const BeforePredict({Key? key, required this.predictCubit}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Image.asset(
            'assets/empty.png',
            color: Colors.green.shade500,
          ),
          Text(
            "You haven't ran any images, tap the below button to use an image from your gallery or camera.",
            style: GoogleFonts.roboto(
                textStyle: Theme.of(context).textTheme.bodyText2,
                fontSize: 36,
                fontStyle: FontStyle.italic,
                color: Colors.black),
          ),
          const SizedBox(
            height: 56,
          ),
          // ignore: deprecated_member_use
          PredictWidget(cubit: predictCubit),
        ],
      ),
    );
  }
}
