class GetOneGroupeModel {
  OneGroupeData? group;

  GetOneGroupeModel.fromJson(Map<String, dynamic> json) {
    group =
        json['group'] != null ? OneGroupeData.fromJson(json['group']) : null;
  }
}

class OneGroupeData {
  int? id;
  String? name;
  String? image;
  String? status;
  String? localRegion;
  int? centerId;
  int? keeperId;
  String? deletedAt;

  OneGroupeData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    status = json['status'];
    centerId = json['center_id'];
    keeperId = json['keeper_id'];
    localRegion = json['region'];
    deletedAt = json['deleted_at'];
  }
}
