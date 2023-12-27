import 'package:dartz/dartz.dart';

import '../../../core/core.dart';
import '../../data.dart';

abstract class IAuthRepository {
  Future<Either<Failure, User?>> signInWithEmail(String email,String password);
  Future<Either<Failure, bool?>> signUpWithEmail(User user);
}

