import 'package:dartz/dartz.dart';

import '../../core/core.dart';
import '../data.dart';

class TestReppsitory extends ITestRepository {
  final ITestRemoteService remoteService;
  final INetworkInfo networkInfo;

  TestReppsitory({required this.remoteService, required this.networkInfo});

  @override
  Future<Either<Failure, TestResponse?>> getTestResponse() async {

    final isConnected = await networkInfo.isConnected;
    try {
      if (isConnected) {
        final remoteData = await remoteService.getTestResponse();
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