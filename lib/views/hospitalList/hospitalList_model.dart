import 'package:equatable/equatable.dart';

/// generate by https://javiercbk.github.io/json_to_dart/
class AutogeneratedHospitalList {
  final List<HospitalListModel> results;

  AutogeneratedHospitalList({this.results});

  factory AutogeneratedHospitalList.fromJson(Map<String, dynamic> json) {
    List<HospitalListModel> temp;
    if (json['results'] != null) {
      temp = <HospitalListModel>[];
      json['results'].forEach((v) {
        temp.add(HospitalListModel.fromJson(v as Map<String, dynamic>));
      });
    }
    return AutogeneratedHospitalList(results: temp);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (this.results != null) {
      data['results'] = this.results.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class HospitalListModel extends Equatable {
  final int id;
  final String name;

  HospitalListModel(this.id, this.name);

  @override
  List<Object> get props => [id, name];

  factory HospitalListModel.fromJson(Map<String, dynamic> json) {
    return HospitalListModel(json['id'] as int, json['name'] as String);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
  
}
