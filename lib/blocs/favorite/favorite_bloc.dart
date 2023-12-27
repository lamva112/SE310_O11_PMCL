import '../../core/core.dart';
import '../../data/data.dart';
import '../blocs.dart';

class FavoriteBloc extends BaseBloc<FavoriteState> {
  final IVocabularyRepository _vocabularyRepository;
  final IUnitRepository _unitRepository;
  final ISharedPreferencesRepository sharedPreferencesRepo;
  FavoriteBloc(this._vocabularyRepository, this._unitRepository,
      this.sharedPreferencesRepo);

  Stream<List<Vocabulary>?> get vocabStream =>
      stateStream.map((event) => event.listVocal);

  Stream<List<Unit>?> get unitStream =>
      stateStream.map((event) => event.listUnit);

  Stream<List<FavoriteUnit>?> get faunitStream =>
      stateStream.map((event) => event.listFaUnit);

  Future<void> loadData() async {
    var userId = await sharedPreferencesRepo.getToken();
    if (userId != null) {
      var data = await getFaListVocal(userId);
      List<String> listVocal = [];
      data?.forEach((element) {
        if (element.vocabularyId != null) {
          listVocal.add(element.vocabularyId!);
        }
      });

      print("cai don data ne  ${listVocal}");
      getListVocal(listVocal)
          .then((value) => emit(
                FavoriteState(state: state, listVocal: value),
              ))
          .catchError(
              (e) => emit(FavoriteState(state: state, error: e.toString())));
    }
  }

  Future<List<FavoriteVocabulary>?> getFaListVocal(String userId) async {
    final singleVocal =
        await _vocabularyRepository.getFavoriteVocab(userId: userId);
    return singleVocal.fold((failure) {
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

  Future<List<FavoriteUnit>?> getFaListUnit(String userId) async {
    final singleUnit = await _unitRepository.getFavoriteUnit(userId: userId);
    return singleUnit.fold((failure) {
      return Future.error(failure);
    }, (data) {
      return data;
    });
  }

  Future<List<Unit>?> getListUnit(List<String> unitId) async {
    final singlistUnit = await _unitRepository.getSingleUnit(unitId);
    return singlistUnit.fold((failure) {
      return Future.error(failure);
    }, (data) {
      return data;
    });
  }

  Future<void> loadUnit() async {
    if (getUserId() != null) {
      var data = await getFaListUnit(getUserId()!);

      List<String> listVocal = [];
      data?.forEach((element) {
        if (element.unitId != null) {
          listVocal.add(element.unitId!);
        }
      });

      print("cai don data unit ne  ${listVocal}");

      // print("cai don data ne  ${listVocal}");
      getListUnit(listVocal)
          .then((value) => emit(
                FavoriteState(state: state, listUnit: value),
              ))
          .catchError(
              (e) => emit(FavoriteState(state: state, error: e.toString())));
    }
  }

  Future<void> deleteUnit(int index) async {
    if (getUserId() != null) {
      List<Unit> listUnit = state?.listUnit ?? [];
      print("favorite ne ${listUnit}");

      listUnit.removeAt(index);
      print("xoa  ne ${listUnit}");

      List<FavoriteUnit>? fvUnit = await getFaListUnit(getUserId()!);

      if (fvUnit?[index].id != null) {
        _unitRepository
            .deleteUnit(fvUnit?[index].id ?? "")
            .then(
              (value) => value.fold(
                (e) => emit(FavoriteState(state: state, error: e.toString())),
                (data) async {
                  if (data == true) {
                    print("xoa unit xong ròi");
                    emit(FavoriteState(state: state, listUnit: listUnit));
                  } else {
                    print("delete fail nha");
                  }
                },
              ),
            )
            .catchError(
                (e) => emit(FavoriteState(state: state, error: e.toString())));
      } else {
        print("Loi state khong xoa duoc");
      }
    }
  }

  Future<void> deleteVocab(int index) async {
    if (getUserId() != null) {
      List<Vocabulary> listUnit = state?.listVocal ?? [];
      print("favorite ne ${listUnit}");

      listUnit.removeAt(index);
      print("xoa  ne ${listUnit}");

      List<FavoriteVocabulary>? fvUnit = await getFaListVocal(getUserId()!);

      if (fvUnit?[index].id != null) {
        _vocabularyRepository
            .deleteVocab(fvUnit?[index].id ?? "")
            .then(
              (value) => value.fold(
                (e) => emit(FavoriteState(state: state, error: e.toString())),
                (data) async {
                  if (data == true) {
                    print("xoa vocab xong ròi");
                    emit(FavoriteState(state: state, listVocal: listUnit));
                  } else {
                    print("delete vocab fail nha");
                  }
                },
              ),
            )
            .catchError(
                (e) => emit(FavoriteState(state: state, error: e.toString())));
      } else {
        print("Loi state khong vocab xoa duoc");
      }
    }
  }

  String? getUserId() {
    return sharedPreferencesRepo.getToken();
  }
}
