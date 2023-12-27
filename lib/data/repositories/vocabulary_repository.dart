import 'package:dartz/dartz.dart';
import '../data.dart';
import '../../core/core.dart';

class VocabularyRepository extends IVocabularyRepository {
  final IVocabularyRemoteService remoteService;
  final INetworkInfo networkInfo;

  VocabularyRepository(
      {required this.remoteService, required this.networkInfo});

  @override
  Future<Either<Failure, UnitHasVocabularyResponse?>>
      getUnitHasVocabularyResponse(String unitId) async {
    final isConnected = await networkInfo.isConnected;
    try {
      if (isConnected) {
        final remoteData =
            await remoteService.getUnitHasVocabularyResponse(unitId);
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
  Future<Either<Failure, List<Vocabulary>?>> getSingleVocabulary(
      List<String> idList) async {
    final isConnected = await networkInfo.isConnected;
    try {
      if (isConnected) {
        final remoteData =
            await remoteService.getSingleVocabulary(idList);
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
