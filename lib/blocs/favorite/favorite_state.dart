import 'package:equatable/equatable.dart';
import '../../data/data.dart';

class FavoriteState extends Equatable {
  final bool? success;
  final String? error;
  final List<FavoriteVocabulary>? listFa;
  final List<Vocabulary>? listVocal;
  final List<FavoriteUnit>? listFaUnit;
  final List<Unit>? listUnit;

  FavoriteState({
    FavoriteState? state,
    bool? success,
    String? error,
    List<FavoriteVocabulary>? listFa,
    List<Vocabulary>? listVocal,
    List<FavoriteUnit>? listFaUnit,
    List<Unit>? listUnit,
  })  : success = success ?? state?.success,
        error = error ?? state?.error,
        listFa = listFa ?? state?.listFa,
        listVocal = listVocal ?? state?.listVocal,
        listFaUnit = listFaUnit ?? state?.listFaUnit,
        listUnit = listUnit ?? state?.listUnit;

  @override
  List<Object?> get props =>
      [success, error, listFa, listVocal, listFaUnit, listUnit];
}
