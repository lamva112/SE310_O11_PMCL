class Test {
  String? id;
  String? name;
  String? image;
  List<String>? questions;

  Test({this.id, this.name, this.image, this.questions});

  Test.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    questions = json['questions'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['image'] = image;
    data['questions'] = questions;
    return data;
  }
}
