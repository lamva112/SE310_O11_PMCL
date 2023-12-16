import 'package:dartz/dartz.dart';
import '../../../core/core.dart';
import '../../data.dart';

abstract class ISearchRepository {
  Future<Either<Failure, VocabularyResponse?>> getResponse({String? params});
}