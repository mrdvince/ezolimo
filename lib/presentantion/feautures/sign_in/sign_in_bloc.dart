import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/repositories/abstract/user_repository.dart';
import '../auth/auth_bloc.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc({
    required this.userRepository,
    required this.authBloc,
  }) : super(SignInInitialState());
  final AuthBloc authBloc;
  final UserRepository userRepository;

  @override
  Stream<SignInState> mapEventToState(SignInEvent event) async* {
    if (event is SignInPressed) {
      yield SignInProcessingState();
      try {
        final token = await userRepository.signIn(
            email: event.email, password: event.password);
        authBloc.add(LoggedIn(token));
        yield SignInFinishedState();
      } catch (e) {
        yield SignInErrorState(e.toString());
      }
    }
  }
}
