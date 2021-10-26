import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../logic/storage.dart';
import '../../data/repositories/user_repository.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({required this.userRepository}) : super(AuthInitial());
  final UserRepository userRepository;
  Future<void> isAuthenticated() async {
    final token = await _getToken();
    if (token != '') {
      Storage().token = token;
      emit(Authenticated());
    } else {
      emit(Unauthenticated());
    }
  }

  void logOut() {
    _deleteToken();
    emit(Unauthenticated());
  }

  void authenticate(String email, String password) async {
    await userRepository.signIn(email, password).then((token) {
      if (token != '') {
        _saveToken(token);
        emit(Authenticated());
      } else {
        emit(AuthenticationError());
      }
    });
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
