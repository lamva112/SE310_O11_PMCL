import 'package:equatable/equatable.dart';

import '../../data/data.dart';

class TestState extends Equatable {
  final bool? success;
  final String? error;
  final List<Test>? listTest;

  TestState({
    TestState? state,
    bool? success,
    String? error,
    List<Test>? listTest,
  })  : success = success ?? state?.success,
        error = error ?? state?.error,
        listTest = listTest ?? state?.listTest;

  @override
  List<Object?> get props => [success, error,listTest];
}
