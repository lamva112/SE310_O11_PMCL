import '../data.dart';

class UnitHasVocabularyResponse {
  List<UnitHasVocabulary>? unitHasVocabulary;

  UnitHasVocabularyResponse({this.unitHasVocabulary});

  UnitHasVocabularyResponse.fromJson(Map<String, dynamic> json) {
    if (json['UnitHasVocabulary'] != null) {
      unitHasVocabulary = <UnitHasVocabulary>[];
      json['UnitHasVocabulary'].forEach((v) {
        unitHasVocabulary!.add(UnitHasVocabulary.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (unitHasVocabulary != null) {
      data['UnitHasVocabulary'] =
          unitHasVocabulary!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
