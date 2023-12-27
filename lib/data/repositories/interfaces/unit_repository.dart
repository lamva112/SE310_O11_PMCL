
import 'package:dartz/dartz.dart'as dz;

import '../../../core/core.dart';
import '../../data.dart';

abstract class IUnitRepository {
  Future<dz.Either<Failure, UnitResponse?>> getResponse();
  Future<dz.Either<Failure, List<FavoriteUnit>?>> getFavoriteUnit({required String userId});
  Future<dz.Either<Failure, List<Unit>?>> getSingleUnit(List<String> idList);
  Future<dz.Either<Failure, bool>> deleteUnit(String id);
}