
import '../../data.dart';

abstract class IQuestionRemoteService {
  Future<List<Question>?> getSingleQuestion(List<String> idList);
}
