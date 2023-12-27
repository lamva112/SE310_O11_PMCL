import 'package:dartz/dartz.dart';
import '../../core/core.dart';
import '../data.dart';

class QuestionRepository extends IQuestionRepository {
  final IQuestionRemoteService remoteService;
  final INetworkInfo networkInfo;

  QuestionRepository({required this.remoteService, required this.networkInfo});

  @override
  Future<Either<Failure, List<Question>?>> getSingleQuestion(
      List<String> idList) async {
    final isConnected = await networkInfo.isConnected;
    try {
      if (isConnected) {
        final remoteData = await remoteService.getSingleQuestion(idList);
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
