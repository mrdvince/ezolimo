import '../models/user_model.dart';

abstract class UserRepository {
  // signin with email and password and return token
  Future<String> signIn({
    required String email,
    required String password,
  });
  // sign up with email and password and return token
  Future<String> signUp({
    required String name,
    required String email,
    required String password,
  });

  // return user as appuser
  Future<AppUser> getUser();

  // send email forgot password
  Future<void> forgotPassword({
    required String email,
  });
}
