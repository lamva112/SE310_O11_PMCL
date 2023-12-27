import '../../data.dart';

abstract class IAuthRemoteService {
  Future<User?> signInWithEmail(String email, String password);
  Future<bool?> signUpWithEmail(User user);
}
