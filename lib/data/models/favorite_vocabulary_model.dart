class FavoriteVocabulary {
  String? id;
  String? userId;
  String? vocabularyId;

  FavoriteVocabulary({this.id, this.userId, this.vocabularyId});

  FavoriteVocabulary.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    vocabularyId = json['vocabularyId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['userId'] = userId;
    data['vocabularyId'] = vocabularyId;
    return data;
  }
}
