class Options {
  String? id;
  String? value;
  bool? isCorrect;

  Options({this.id, this.value, this.isCorrect});

  Options.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    value = json['value'];
    isCorrect = json['isCorrect'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['value'] = value;
    data['isCorrect'] = isCorrect;
    return data;
  }
}

