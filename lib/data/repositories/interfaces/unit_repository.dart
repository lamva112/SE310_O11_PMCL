import 'package:dartz/dartz.dart';

import '../../../core/core.dart';
import '../../data.dart';

abstract class IUnitRepository {
  Future<Either<Failure, UnitResponse?>> getResponse();
}