part of 'gpt_cubit.dart';

abstract class GptState extends Equatable {
  const GptState();

  @override
  List<Object> get props => [];
  String get about => '';
  String get causes => '';
  String get treat => '';
}

class GptInitial extends GptState {}

class GptDoneState extends GptState {}

class GptAboutDoneState extends GptState {
  final String aboutPathogen;

  const GptAboutDoneState(this.aboutPathogen);
  @override
  String get about => aboutPathogen;
}


class GptCauseDoneState extends GptState {
  final String causesPathogen;

  const GptCauseDoneState(this.causesPathogen);
  @override
  String get causes => causesPathogen;
}


class GptTreatDoneState extends GptState {
  final String treatPathogen;

  const GptTreatDoneState(this.treatPathogen);
  @override
  String get treat => treatPathogen;
}
