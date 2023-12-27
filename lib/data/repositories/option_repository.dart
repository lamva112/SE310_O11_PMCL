import 'package:dartz/dartz.dart';
import '../../core/core.dart';
import '../../core/error/failures.dart';
import '../data.dart';

class OptionRepository extends IOptionRepository {
  final IOptionRemoteService remoteService;
  final INetworkInfo networkInfo;

  OptionRepository({required this.remoteService, required this.networkInfo});

  @override
  Future<Either<Failure, List<Options>?>> getSingleOption(List<String> idList) async {
final isConnected = await networkInfo.isConnected;
    try {
      if (isConnected) {
        final remoteData = await remoteService.getSingleOption(idList);
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
