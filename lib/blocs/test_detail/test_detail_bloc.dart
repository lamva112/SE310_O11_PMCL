import '../../data/data.dart';
import '../../core/core.dart';
import '../blocs.dart';

class TestDetailBloc extends BaseBloc<TestDetailState> {
  final IOptionRepository _optionRepository;
  TestDetailBloc(this._optionRepository);

  Stream<bool?> get successStream =>
      stateStream.map((event) => event.success).distinct();
  Stream<String?> get errorStream => stateStream.map((event) => event.error);

  Stream<List<Question>?> get questionStream =>
      stateStream.map((event) => event.listQuestion);

  Stream<List<String>?> get listIdStream =>
      stateStream.map((event) => event.idList);

  Stream<List<Options>?> get optionStream =>
      stateStream.map((event) => event.optionList);

  void getQuestionList(List<Question> list) {
    emit(TestDetailState(state: state, listQuestion: list));
  }

  void getListId(List<String> idList) {
    // _optionRepository
    //     .getSingleOption(idList)
    //     .then(
    //       (value) => value.fold(
    //         (e) => emit(TestDetailState(state: state, error: e.toString())),
    //         (data) async {
    //           emit(TestDetailState(state: state, optionList: data));
    //         },
    //       ),
    //     )
    //     .catchError(
    //         (e) => emit(TestDetailState(state: state, error: e.toString())));
    emit(TestDetailState(state: state, idList: idList));
  }
}
