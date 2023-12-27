import 'package:dartz/dartz.dart';

import '../../../core/core.dart';
import '../../data.dart';

abstract class IQuestionRepository {
  Future<Either<Failure, List<Question>?>> getSingleQuestion(List<String> idList);
}
