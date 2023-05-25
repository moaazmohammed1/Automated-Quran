import 'data_model.dart';

class StudentsInGroupeModel {
  List<Group>? group = [];
  StudentsInGroupeModel.fromJson(Map<String, dynamic> json) {
    if (json['group'] != null) {
      json['group'].forEach((v) {
        group!.add(Group.fromJson(v));
      });
    }
  }
}

class Group {
  int? id;
  String? name;
  String? image;
  String? status;
  String? localRegion;
  int? centerId;
  int? keeperId;
  String? deletedAt;
  List<Data>? students = [];

  Group.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    status = json['status'];
    localRegion = json['region'];
    centerId = json['center_id'];
    keeperId = json['keeper_id'];
    deletedAt = json['deleted_at'];

    if (json['students'] != null) {
      json['students'].forEach((value) {
        students!.add(Data.fromJson(value));
      });
    }
  }
}
