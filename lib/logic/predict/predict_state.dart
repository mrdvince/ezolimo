part of 'predict_cubit.dart';

abstract class PredictState extends Equatable {
  const PredictState();

  @override
  List<Object> get props => [];
  Object? get imageFile => null;
  Predictions? get preds => null;
}

class PredictInitial extends PredictState {}

class ImageSelectedState extends PredictState {
  final String? image;

  const ImageSelectedState(this.image);

  @override
  Object? get imageFile => image;
}

class ImageErrorState extends PredictState {}

class NullIfyImage extends PredictState {
  @override
  Object? get imageFile => null;
}

class PredictDoneState extends PredictState {
  final Predictions predictions;

  const PredictDoneState(this.predictions);

  @override
  Predictions get preds => predictions;
}

class PredictLoadingState extends PredictState {}
