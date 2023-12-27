import 'package:dartz/dartz.dart';
import '../data.dart';
import '../../core/core.dart';
import '../models/unit_model.dart' as unit;

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

  @override
  Future<Either<Failure, List<FavoriteUnit>?>> getFavoriteUnit(
      {required String userId}) async {
    final isConnected = await networkInfo.isConnected;
    try {
      if (isConnected) {
        final remoteData = await remoteService.getFavoriteUnit(userId);
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

  @override
  Future<Either<Failure, List<unit.Unit>?>> getSingleUnit(
      List<String> idList) async {
    final isConnected = await networkInfo.isConnected;
    try {
      if (isConnected) {
        final remoteData = await remoteService.getSingleUnit(idList);
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
  
  @override
  Future<Either<Failure, bool>> deleteUnit(String id) async {
    final isConnected = await networkInfo.isConnected;
    try {
      if (isConnected) {
        final remoteData = await remoteService.deleteFavoriteUnit(id);
        return Right(remoteData);
      } else {
        return const Right(false);
      }
    } on ServerException {
      return Left(ServerFailure());
    } catch (e) {
      return Left(UnknownFailure());
    }
  }
}
