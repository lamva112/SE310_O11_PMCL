import '../../core/core.dart';
import '../../data/data.dart';
import '../blocs.dart';

class TestBloc extends BaseBloc<TestState> {
  final ITestRepository _testRepository;
  TestBloc(this._testRepository);

  Stream<bool?> get successStream =>
      stateStream.map((event) => event.success).distinct();
  Stream<String?> get errorStream => stateStream.map((event) => event.error);

  Stream<List<Test>?> get testStream =>
      stateStream.map((event) => event.listTest);

  Future<void> loadData() async {
    _testRepository
        .getTestResponse()
        .then(
          (value) => value.fold(
            (e) => emit(TestState(state: state, error: e.toString())),
            (data) async {
              emit(TestState(state: state, listTest: data?.testList));
            },
          ),
        )
        .catchError((e) => emit(TestState(state: state, error: e.toString())));
  }
}
