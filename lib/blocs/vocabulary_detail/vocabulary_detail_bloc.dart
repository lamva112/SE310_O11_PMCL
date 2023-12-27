import 'dart:math';

import '../../data/data.dart';

import '../../core/core.dart';
import '../blocs.dart';

class VocabularyDetailBloc extends BaseBloc<VocabularyDetailState> {
  final IVocabularyRepository _vocabularyRepository;
  VocabularyDetailBloc(this._vocabularyRepository);

  Stream<bool?> get successStream =>
      stateStream.map((event) => event.success).distinct();
  Stream<String?> get errorStream => stateStream.map((event) => event.error);

  Stream<List<Vocabulary>?> get unitStream =>
      stateStream.map((event) => event.listVocal);


  Future<void> loadData(String unitId) async {

    var data = await getListVocalId(unitId);
    List<String> listVocal = [];
    data?.unitHasVocabulary?.forEach((element) {
      if (element.vocabularyId != null) {
        listVocal.add(element.vocabularyId!);
      }
    });

    getListVocal(listVocal)
        .then((value) => emit(
              VocabularyDetailState(state: state, listVocal: value),
            ))
        .catchError((e) =>
            emit(VocabularyDetailState(state: state, error: e.toString())));
  }

  Future<UnitHasVocabularyResponse?> getListVocalId(String unitId) async {
    final shippingAddressEither =
        await _vocabularyRepository.getUnitHasVocabularyResponse(unitId);
    return shippingAddressEither.fold((failure) {
      return Future.error(failure);
    }, (data) {
      return data;
    });
  }

  Future<List<Vocabulary>?> getListVocal(List<String> unitId) async {
    final singleVocal = await _vocabularyRepository.getSingleVocabulary(unitId);
    return singleVocal.fold((failure) {
      return Future.error(failure);
    }, (data) {
      return data;
    });
  }
}
