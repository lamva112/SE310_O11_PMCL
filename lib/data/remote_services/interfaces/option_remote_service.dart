
import '../../data.dart';

abstract class IOptionRemoteService {
  Future<List<Options>?> getSingleOption(List<String> idList);
}