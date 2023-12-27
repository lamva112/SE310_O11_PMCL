import 'package:equatable/equatable.dart';

import '../../data/data.dart';

class WorkspaceState extends Equatable {
  final bool? success;
  final String? error;
  final User? user;

  WorkspaceState({
    WorkspaceState? state,
    bool? success,
    String? error,
    User? user
    // Pagination? pagination,
    // List<TemplateModel>? listTemplate,
    // List<ProjectModel>? listProject
  })  : success = success ?? state?.success,
        error = error ?? state?.error, user = user ?? state?.user;

  @override
  List<Object?> get props => [success, error,user];
}
