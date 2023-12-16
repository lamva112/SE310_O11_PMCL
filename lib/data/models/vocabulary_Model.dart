class Vocabulary {
  String? id;
  String? type;
  String? word;
  String? hint;
  String? phonetics;
  String? pronouce;
  String? image;
  String? meaning;

  Vocabulary(
      {this.id,
      this.type,
      this.word,
      this.hint,
      this.phonetics,
      this.pronouce,
      this.image,
      this.meaning});

  Vocabulary.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    word = json['word'];
    hint = json['hint'];
    phonetics = json['phonetics'];
    pronouce = json['pronouce'];
    image = json['image'];
    meaning = json['meaning'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['id'] = id;
    data['type'] = type;
    data['word'] = word;
    data['hint'] = hint;
    data['phonetics'] = phonetics;
    data['pronouce'] = pronouce;
    data['image'] = image;
    data['meaning'] = meaning;
    return data;
  }
}
