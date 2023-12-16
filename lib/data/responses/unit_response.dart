import '../data.dart';

class UnitResponse {
  List<Unit>? units;

  UnitResponse({this.units});

  UnitResponse.fromJson(Map<String, dynamic> json) {
    if (json['Unit'] != null) {
      units = <Unit>[];
      json['Unit'].forEach((v) {
        units!.add(Unit.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (units != null) {
      data['Unit'] = units!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  UnitResponse copyWith({
    List<Unit>? unit,
  }) {
    return UnitResponse(
      units: unit ?? this.units,
    );
  }
}
