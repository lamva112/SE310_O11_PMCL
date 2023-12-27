class FavoriteUnit {
  String? id;
  String? userId;
  String? unitId;

  FavoriteUnit({this.id, this.userId, this.unitId});

  FavoriteUnit.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    unitId = json['unitId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['userId'] = userId;
    data['unitId'] = unitId;
    return data;
  }
}
