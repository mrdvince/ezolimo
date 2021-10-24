part of 'predict_cubit.dart';

abstract class PredictState extends Equatable {
  const PredictState();

  @override
  List<Object> get props => [];

  Object? get imageFile => null;
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
  final Predictions preds;
  const PredictDoneState(this.preds);

  @override
  List<Object> get props => [preds];
}
