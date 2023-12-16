import '../../data.dart';

abstract class ISearchRemoteService {
  Future<VocabularyResponse?> getSearchResponse({String? value});
}
