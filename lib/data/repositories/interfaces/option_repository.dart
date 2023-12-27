import 'package:dartz/dartz.dart';

import '../../../core/core.dart';
import '../../data.dart';

abstract class IOptionRepository {
  Future<Either<Failure, List<Options>?>> getSingleOption(List<String> idList);
}