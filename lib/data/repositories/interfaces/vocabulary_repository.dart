import 'package:dartz/dartz.dart';
import '../../../core/core.dart';
import '../../data.dart';

abstract class IVocabularyRepository {
  Future<Either<Failure, UnitHasVocabularyResponse?>>
      getUnitHasVocabularyResponse(String unitId);
  Future<Either<Failure, List<Vocabulary>?>> getSingleVocabulary(List<String> idList);
  Future<Either<Failure, bool?>> addFavoriteUNIT({required String userId, required String unitId});
  Future<Either<Failure, List<FavoriteVocabulary>?>> getFavoriteVocab({required String userId});
  Future<Either<Failure, bool>> deleteVocab(String id);
}
