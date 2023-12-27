import '../../data.dart';

abstract class IVocabularyRemoteService {
  Future<UnitHasVocabularyResponse?> getUnitHasVocabularyResponse(String unitId);
  Future<List<Vocabulary>?> getSingleVocabulary(List<String> idList);
  Future<bool?> addFavoriteUnit(String unitId, String userId);
  Future<List<FavoriteVocabulary>?> getFavoriteVocabulary(String userId);
  Future<bool> deleteFavoriteVocab(String id);
}
