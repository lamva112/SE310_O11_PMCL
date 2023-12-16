import 'package:se310_o11_pmcl/data/data.dart';

import '../../core/core.dart';
import '../blocs.dart';

class VocabularyBloc extends BaseBloc<VocabularyState> {
  final IUnitRepository _unitRepository;
  VocabularyBloc(this._unitRepository);

  Stream<bool?> get successStream =>
      stateStream.map((event) => event.success).distinct();
  Stream<String?> get errorStream => stateStream.map((event) => event.error);

  Stream<List<Unit>?> get unitStream =>
      stateStream.map((event) => event.listUnit);

  Future<void> loadData() async {
    _unitRepository
        .getResponse()
        .then(
          (value) => value.fold(
            (e) => emit(VocabularyState(state: state, error: e.toString())),
            (data) async {
              emit(VocabularyState(state: state, listUnit: data?.units));
            },
          ),
        )
        .catchError(
            (e) => emit(VocabularyState(state: state, error: e.toString())));
  }
}
