import 'package:dartz/dartz.dart';
import '../../../core/core.dart';
import '../../data.dart';

abstract class ISearchRepository {
  Future<Either<Failure, VocabularyResponse?>> getResponse({String? params});
  Future<Either<Failure, bool?>> addFavoriteVocabulary({required String userId, required String vocaId});
}
