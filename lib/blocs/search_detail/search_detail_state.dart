import 'package:equatable/equatable.dart';

import '../../data/data.dart';

class SearchDetailState extends Equatable {
  final bool? success;
  final String? error;
  

  SearchDetailState({
    SearchDetailState? state,
    bool? success,
    String? error,
    List<Vocabulary>? vocaList,
  })  : success = success ?? state?.success,
        error = error ?? state?.error
        ;

  @override
  List<Object?> get props => [success, error,];
}
