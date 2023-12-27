import 'package:dartz/dartz.dart';

import '../../core/core.dart';
import '../data.dart';

class AuthRepository extends IAuthRepository {
  final IAuthRemoteService remoteService;
  final INetworkInfo networkInfo;

  AuthRepository({required this.remoteService, required this.networkInfo});

  @override
  Future<Either<Failure, User?>> signInWithEmail(
      String email, String password) async {
    final isConnected = await networkInfo.isConnected;
    try {
      if (isConnected) {
        final remoteData = await remoteService.signInWithEmail(email, password);
        return Right(remoteData);
      } else {
        return Right(null);
      }
    } on ServerException {
      return Left(ServerFailure());
    } catch (e) {
      print("Lỗi nè ${e}");
      return Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, bool?>> signUpWithEmail(User user) async {
    final isConnected = await networkInfo.isConnected;
    try {
      if (isConnected) {
        final remoteData = await remoteService.signUpWithEmail(user);
        return Right(remoteData);
      } else {
        return Right(null);
      }
    } on ServerException {
      return Left(ServerFailure());
    } catch (e) {
      return Left(UnknownFailure());
    }
  }
}
