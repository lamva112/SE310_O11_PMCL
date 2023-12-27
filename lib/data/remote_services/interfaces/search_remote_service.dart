import '../../data.dart';

abstract class ISearchRemoteService {
  Future<VocabularyResponse?> getSearchResponse({String? value});
  Future<bool?> addFavoriteVocabulary(String vocaId, String userId);
}
