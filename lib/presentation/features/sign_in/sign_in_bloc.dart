import 'package:bloc/bloc.dart';
import 'package:ezolimo/data/http/http_client.dart';
import 'package:flutter/cupertino.dart';
import '../../../data/repositories/user_repository.dart';
import '../auth/auth_bloc.dart';
import 'package:equatable/equatable.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final UserRepository userRepository;
  final AuthBloc authenticationBloc;

  SignInBloc({
    required this.userRepository,
    required this.authenticationBloc,
  })  : assert(userRepository != null),
        assert(authenticationBloc != null),
        super(SignInInitialState());
  @override
  Stream<SignInState> mapEventToState(
    SignInEvent event,
  ) async* {
    // normal sign in
    if (event is SignInPressed) {
      yield SignInProcessingState();
      try {
        var token =
            await getToken(email: event.email, password: event.password);
        debugPrint(token as String);
        authenticationBloc.add(LoggedIn(token));
        yield SignInFinishedState();
      } catch (error) {
        yield SignInErrorState(error as String);
      }
    }

    // sign in with facebook
    if (event is SignInPressedFacebook) {
      yield SignInProcessingState();
      try {
        await Future.delayed(
          Duration(milliseconds: 300),
        ); //TODO use real auth service

        yield SignInFinishedState();
      } catch (error) {
        yield SignInErrorState(error as String);
      }
    }

    // sign in with google
    if (event is SignInPressedGoogle) {
      yield SignInProcessingState();
      try {
        await Future.delayed(
          Duration(milliseconds: 100),
        ); //TODO use real auth service

        yield SignInFinishedState();
      } catch (error) {
        yield SignInErrorState(error as String);
      }
    }
  }
}
