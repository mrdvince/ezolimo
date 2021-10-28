import '../../../../core/constants/urls.dart';
import '../../../../logic/predict/predict_cubit.dart';
import 'gpt_davinci_engine.dart';
import 'package:flutter/material.dart';

fetchPredictions(PredictCubit cubit, context) {
  var _predictions = cubit.state.preds;
  return Column(
    children: [
      Image.network(
        '${ServerUrls.baseUrl}/${_predictions!.path}/${_predictions.filename}',
        fit: BoxFit.cover,
        height: 300.0,
        width: MediaQuery.of(context).size.width,
      ),
      const Padding(
        padding: EdgeInsets.all(8.0),
        child: Text(
          'Cropped pathogen regions',
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.blueGrey),
        ),
      ),
      SizedBox(
        height: 200,
        child: ListView.builder(
          padding: const EdgeInsets.only(left: 10.0),
          scrollDirection: Axis.horizontal,
          itemCount: _predictions.imageCrops.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    Image.network(
                      '${ServerUrls.baseUrl}/${_predictions.imageCrops[index]}',
                      height: 80,
                      width: 80,
                      fit: BoxFit.fill,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      _predictions.pathogenNames[index],
                      style: const TextStyle(
                          color: Colors.blueGrey,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      GptDavinciEngine(predictions: _predictions)
    ],
  );
}
