import 'package:dartz/dartz.dart';

import '../../core/core.dart';

import '../data.dart';

class SearchRepository extends ISearchRepository {
  final ISearchRemoteService remoteService;

  final INetworkInfo networkInfo;
  SearchRepository({
    required this.remoteService,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, VocabularyResponse?>> getResponse(
      {String? params}) async {
    final isConnected = await networkInfo.isConnected;
    try {
      if (isConnected) {
        final remoteData = await remoteService.getSearchResponse();
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
  Future<Either<Failure, bool?>> addFavoriteVocabulary(
      {required String userId, required String vocaId}) async {
    final isConnected = await networkInfo.isConnected;
    try {
      if (isConnected) {
        final remoteData =
            await remoteService.addFavoriteVocabulary(vocaId, userId);
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
