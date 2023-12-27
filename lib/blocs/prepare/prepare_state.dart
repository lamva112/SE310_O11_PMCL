import 'package:equatable/equatable.dart';
import '../../data/data.dart';

class PrepareState extends Equatable {
  final bool? success;
  final String? error;
  final List<Question>? listQuestion;

  PrepareState(
      {PrepareState? state,
      bool? success,
      String? error,
      List<Question>? listQuestion})
      : success = success ?? state?.success,
        error = error ?? state?.error,
        listQuestion = listQuestion ?? state?.listQuestion;

  @override
  List<Object?> get props => [success, error, listQuestion];
}
