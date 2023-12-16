import 'package:equatable/equatable.dart';

import '../../data/data.dart';

class VocabularyState extends Equatable {
  final bool? success;
  final String? error;
  final List<Unit>? listUnit;

  VocabularyState(
      {VocabularyState? state,
      bool? success,
      String? error,
      List<Unit>? listUnit})
      : success = success ?? state?.success,
        error = error ?? state?.error,
        listUnit = listUnit ?? state?.listUnit;

  @override
  List<Object?> get props => [success, error, listUnit];
}
