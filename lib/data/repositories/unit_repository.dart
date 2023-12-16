import 'package:dartz/dartz.dart';
import '../data.dart';
import '../../core/core.dart';

class UnitReppsitory extends IUnitRepository {
  final IUnitRemoteService remoteService;
  final INetworkInfo networkInfo;

  UnitReppsitory({required this.remoteService, required this.networkInfo});

  @override
  Future<Either<Failure, UnitResponse?>> getResponse() async {

    final isConnected = await networkInfo.isConnected;
    try {
      if (isConnected) {
        final remoteData = await remoteService.getUnitResponse();
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
