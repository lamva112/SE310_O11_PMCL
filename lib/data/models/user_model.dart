import '../../extensions/string_extension.dart';

class User {
  String? id;
  String? email;
  String? passWord;
  String? userName;
  String? dateOfBirth;

  User({this.id, this.email, this.passWord, this.userName, this.dateOfBirth});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    passWord = json['passWord'];
    userName = json['userName'];
    dateOfBirth = (json['dateOfBirth']as String).covertToAppDateTime();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['email'] = email;
    data['passWord'] = passWord;
    data['userName'] = userName;
    data['dateOfBirth'] = dateOfBirth;
    return data;
  }

  User copyWith({
    String? id,
    String? email,
    String? passWord,
    String? userName,
    String? dateOfBirth,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      passWord: passWord ?? this.passWord,
      userName: userName ?? this.userName,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
    );
  }

}
