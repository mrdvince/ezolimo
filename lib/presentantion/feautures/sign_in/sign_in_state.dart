part of 'sign_in_bloc.dart';

abstract class SignInState extends Equatable {
  const SignInState();

  @override
  List<Object> get props => [];
}

class SignInInitial extends SignInState {}

class SignInProcessingState extends SignInState {}

class SignInErrorState extends SignInState {
  const SignInErrorState(this.error);

  final String error;
  @override
  List<Object> get props => [error];
}

class SignInFinishedState extends SignInState {}
