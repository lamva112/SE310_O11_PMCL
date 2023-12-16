import '../../core/core.dart';
import '../../data/data.dart';
import '../blocs.dart';

class SearchDetailBloc extends BaseBloc<SearchDetailState> {
  final ISearchRepository _searchRepository;

  SearchDetailBloc(this._searchRepository);

  
}
