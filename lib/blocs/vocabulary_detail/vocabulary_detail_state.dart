import 'package:equatable/equatable.dart';

import '../../data/data.dart';

class VocabularyDetailState extends Equatable {
  final bool? success;
  final String? error;
  List<Vocabulary>? listVocal;
  List<UnitHasVocabulary>? listUnit;
  

  VocabularyDetailState({
    VocabularyDetailState? state,
    bool? success,
    String? error,
    List<UnitHasVocabulary>? listUnit,
    List<Vocabulary>? listVocal,
  })  : success = success ?? state?.success,
        error = error ?? state?.error,
        listUnit = listUnit ?? state?.listUnit,
        listVocal = listVocal ?? state?.listVocal;

  @override
  List<Object?> get props => [success, error, listUnit, listVocal];
}
