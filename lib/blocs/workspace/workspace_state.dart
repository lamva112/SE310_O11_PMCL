import 'package:equatable/equatable.dart';

class WorkspaceState extends Equatable {
  final bool? success;
  final String? error;

  WorkspaceState({
    WorkspaceState? state,
    bool? success,
    String? error,
    // Pagination? pagination,
    // List<TemplateModel>? listTemplate,
    // List<ProjectModel>? listProject
  })  : success = success ?? state?.success,
        error = error ?? state?.error;

  @override
  List<Object?> get props => [success, error];
}
