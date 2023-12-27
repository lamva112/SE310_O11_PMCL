import '../../core/core.dart';
import '../../data/data.dart';
import '../blocs.dart';

class WorkspaceBloc extends BaseBloc<WorkspaceState> {

  Stream<User?> get userStream =>
      stateStream.map((event) => event.user);

  void getUser(User? user) {
    emit(WorkspaceState(state: state,user: user));
  }
}
