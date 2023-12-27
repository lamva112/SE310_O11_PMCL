import 'package:dartz/dartz.dart';
import '../../../core/error/failures.dart';
import '../../data.dart';

abstract class ITestRepository {
  Future<Either<Failure, TestResponse?>> getTestResponse();
}