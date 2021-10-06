import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import '../../../config/storage.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(Uninitialized());

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    // app start
    if (event is AppStarted) {
      final token = await _getToken();
      if (token != '') {
        Storage().token = token;
        yield Authenticated();
      } else {
        yield Unauthenticated();
      }
    }
    // log in
    if (event is LoggedIn) {
      Storage().token = event.token;
      await _saveToken(event.token);
      yield Authenticated();
    }
    // log out
    if (event is LoggedOut) {
      Storage().token = '';
      await _deleteToken();
      yield Unauthenticated();
    }
  }
}

// delete token from storage
Future<void> _deleteToken() async {
  await Storage().secureStorage.delete(key: 'access_token');
}

// save token to storage
Future<void> _saveToken(String token) async {
  await Storage().secureStorage.write(key: 'access_token', value: token);
}

// get token
Future<String> _getToken() async {
  return await Storage().secureStorage.read(key: 'access_token') ?? '';
}
