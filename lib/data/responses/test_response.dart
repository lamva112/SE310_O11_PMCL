import '../models/test_model.dart';

class TestResponse {
  List<Test>? testList;

  TestResponse({this.testList});

  TestResponse.fromJson(Map<String, dynamic> json) {
    if (json['test'] != null) {
      testList = <Test>[];
      json['test'].forEach((v) {
        testList!.add(new Test.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (testList != null) {
      data['test'] = testList!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  TestResponse copyWith({
    List<Test>? testList,
  }) {
    return TestResponse(
      testList: testList ?? this.testList,
    );
  }

}

