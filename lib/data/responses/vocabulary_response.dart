// ignore_for_file: unnecessary_this

import '../data.dart';

class VocabularyResponse {
  List<Vocabulary>? vocabulary;

  VocabularyResponse({this.vocabulary});

  VocabularyResponse.fromJson(Map<String, dynamic> json) {
    if (json['vocabulary'] != null) {
      vocabulary = <Vocabulary>[];
      json['vocabulary'].forEach((v) {
        vocabulary!.add(Vocabulary.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.vocabulary != null) {
      data['vocabulary'] = this.vocabulary!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  VocabularyResponse copyWith({
    List<Vocabulary>? vocabulary,
  }) {
    return VocabularyResponse(
      vocabulary: vocabulary ?? this.vocabulary,
    );
  }
}
