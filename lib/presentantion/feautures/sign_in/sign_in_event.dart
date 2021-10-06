part of 'sign_in_bloc.dart';

abstract class SignInEvent extends Equatable {
  const SignInEvent();

  @override
  List<Object> get props => [];
}

class SignInPressed extends SignInEvent {
  const SignInPressed(this.email, this.password);

  final String email;
  final String password;

  @override
  List<Object> get props => [email, password];
}

class SignInPressedFacebook extends SignInEvent {}

class SignInPressedGoogle extends SignInEvent {}
