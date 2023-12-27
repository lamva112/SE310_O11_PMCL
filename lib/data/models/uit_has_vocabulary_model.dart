class UnitHasVocabulary {
  String? id;
  String? unitId;
  String? vocabularyId;

  UnitHasVocabulary({this.id, this.unitId, this.vocabularyId});

  UnitHasVocabulary.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    unitId = json['unitId'];
    vocabularyId = json['vocabularyId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['unitId'] = unitId;
    data['vocabularyId'] = vocabularyId;
    return data;
  }

  
}
