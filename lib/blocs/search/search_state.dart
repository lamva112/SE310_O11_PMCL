import 'package:equatable/equatable.dart';

import '../../data/data.dart';

class SearchState extends Equatable {
  final bool? success;
  final String? error;
  final List<Vocabulary>? vocaList;
  final List<Vocabulary>? searchList;

  SearchState({
    SearchState? state,
    bool? success,
    String? error,
    List<Vocabulary>? vocaList,
    List<Vocabulary>? searchList,
  })  : success = success ?? state?.success,
        error = error ?? state?.error,
        vocaList = vocaList ?? state?.vocaList,
        searchList = searchList ?? state?.searchList;

  @override
  List<Object?> get props => [success, error,vocaList,searchList];
}
