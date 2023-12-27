import 'dart:math';

import '../../data/data.dart';

import '../../core/core.dart';
import '../blocs.dart';

class VocabularyDetailBloc extends BaseBloc<VocabularyDetailState> {
  final IVocabularyRepository _vocabularyRepository;
  final ISharedPreferencesRepository sharedPreferencesRepo;
  VocabularyDetailBloc(this._vocabularyRepository, this.sharedPreferencesRepo);

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
        .then((value) => {
              print("qua day roi ne"),
              emit(
                VocabularyDetailState(state: state, listVocal: value),
              )
            })
        .catchError((e) {
      print("Khong6 co qua nha");
      emit(VocabularyDetailState(state: state, error: e.toString()));
    });
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

  Future<void> addToFavorite(String unitId) async {
    if (getUserId() != null) {
      _vocabularyRepository
          .addFavoriteUNIT(userId: getUserId() ?? "", unitId: unitId)
          .then(
            (value) => value.fold(
              (e) => emit(
                  VocabularyDetailState(state: state, error: e.toString())),
              (data) async {
                if (data == true) {
                  print("Add favorite unit successfully");
                }
              },
            ),
          )
          .catchError((e) =>
              emit(VocabularyDetailState(state: state, error: e.toString())));
    }
  }

  String? getUserId() {
    return sharedPreferencesRepo.getToken();
  }
}
