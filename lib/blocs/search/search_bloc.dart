import '../../core/core.dart';
import '../../data/data.dart';
import '../blocs.dart';

class SearchBloc extends BaseBloc<SearchState> {
  final ISearchRepository _searchRepository;
  SearchBloc(this._searchRepository);

  Stream<bool?> get successStream =>
      stateStream.map((event) => event.success).distinct();
  Stream<String?> get errorStream => stateStream.map((event) => event.error);

  Stream<List<Vocabulary>?> get vocalStream =>
      stateStream.map((event) => event.searchList);

  Future<void> loadData() async {
    _searchRepository
        .getResponse()
        .then(
          (value) => value.fold(
            (e) => emit(SearchState(state: state, error: e.toString())),
            (data) async {
              emit(SearchState(state: state, vocaList: data?.vocabulary));
            },
          ),
        )
        .catchError(
            (e) => emit(SearchState(state: state, error: e.toString())));
  }

  void searchVocabulary(String text) {
    //List<Vocabulary> vocabularyList = state?.vocaList ?? [];

    List<Vocabulary>? matchingVocabulary =
        state?.vocaList?.where((v) => v.word!.contains(text)).toList();
    emit(SearchState(state: state, searchList: matchingVocabulary));
  }
}
