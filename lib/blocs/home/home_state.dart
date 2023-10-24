import 'package:equatable/equatable.dart';

class HomeState extends Equatable {
  final bool? success;
  final String? error;

  HomeState({
    HomeState? state,
    bool? success,
    String? error,
  })  : success = success ?? state?.success,
        error = error ?? state?.error;

  @override
  List<Object?> get props => [success, error];
}
