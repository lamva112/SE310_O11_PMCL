import 'package:equatable/equatable.dart';
import '../../data/data.dart';

class TestDetailState extends Equatable {
  final bool? success;
  final String? error;
  final List<Question>? listQuestion;
  final List<String>? idList;
  final List<Options>? optionList;

  TestDetailState({
    TestDetailState? state,
    bool? success,
    String? error,
    List<Question>? listQuestion,
    List<String>? idList,
    List<Options>? optionList,
  })  : success = success ?? state?.success,
        error = error ?? state?.error,
        listQuestion = listQuestion ?? state?.listQuestion,
        idList = idList??state?.idList,
        optionList = optionList??state?.optionList;

  @override
  List<Object?> get props => [success, error,listQuestion,idList,optionList];
}
