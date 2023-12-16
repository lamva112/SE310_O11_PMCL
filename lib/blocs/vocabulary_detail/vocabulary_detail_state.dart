import 'package:equatable/equatable.dart';

class VocabularyDetailState extends Equatable {
  final bool? success;
  final String? error;

  VocabularyDetailState({
    VocabularyDetailState? state,
    bool? success,
    String? error,
  })  : success = success ?? state?.success,
        error = error ?? state?.error;

  @override
  List<Object?> get props => [success, error];
}
