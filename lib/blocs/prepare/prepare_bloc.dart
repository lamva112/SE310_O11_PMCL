import '../../core/core.dart';
import '../../data/data.dart';
import '../blocs.dart';

class PrepareBloc extends BaseBloc<PrepareState> {
  final IQuestionRepository _questionRepository;

  PrepareBloc(this._questionRepository);

  Stream<bool?> get successStream =>
      stateStream.map((event) => event.success).distinct();
  Stream<String?> get errorStream => stateStream.map((event) => event.error);

  Stream<List<Question>?> get quesTionStream => stateStream.map((event) => event.listQuestion);

  Future<void> loadData(List<String> questionId) async {
    getListQuestion(questionId).then((value) {
      emit(PrepareState(state: state, listQuestion: value));
    }).catchError((e) {
      emit(PrepareState(state: state, error: e.toString()));
    });
  }

  Future<List<Question>?> getListQuestion(List<String> questionId) async {
    final singleVocal = await _questionRepository.getSingleQuestion(questionId);
    return singleVocal.fold((failure) {
      return Future.error(failure);
    }, (data) {
      return data;
    });
  }
}
