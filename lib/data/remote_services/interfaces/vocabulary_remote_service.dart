import '../../data.dart';

abstract class IVocabularyRemoteService {
  Future<UnitHasVocabularyResponse?> getUnitHasVocabularyResponse(String unitId);
  Future<List<Vocabulary>?> getSingleVocabulary(List<String> idList);

}
