import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// ignore: implementation_imports
import 'package:provider/src/provider.dart';

import '../../../../data/models/res_model.dart';
import '../../../../logic/gpt/gpt_cubit.dart';

class GptDavinciEngine extends StatelessWidget {
  final Predictions predictions;

  const GptDavinciEngine({Key? key, required this.predictions})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final gptcubit = context.watch<GptCubit>();
    final prediction = predictions.pathogenNames[0];
    gptcubit.fetchAbout(prediction);
    return Column(
      children: [
        const Text(
          'About pathogen',
          style: TextStyle(
              color: Colors.blueGrey,
              fontSize: 26,
              fontWeight: FontWeight.w600),
        ),
        gptcubit.state is GptAboutDoneState
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  gptcubit.state.about,
                  style: const TextStyle(fontSize: 16),
                ),
              )
            : const CircularProgressIndicator()
      ],
    );
  }
}
