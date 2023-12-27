class Question {
  String? id;
  bool? type;
  String? title;
  String? description;
  String? answer;
  int? point;
  List<String>? options;

  Question(
      {this.id,
      this.type,
      this.title,
      this.description,
      this.answer,
      this.point,
      this.options});

  Question.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    title = json['title'];
    description = json['description'];
    answer = json['answer'];
    point = json['point'];
    options = json['options'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['type'] = type;
    data['title'] = title;
    data['description'] = description;
    data['answer'] = answer;
    data['point'] = point;
    data['options'] = options;
    return data;
  }
}
