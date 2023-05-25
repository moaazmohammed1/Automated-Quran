class AllGroupsModel {
  List<GroupeData>? groups = [];

  AllGroupsModel.fromJson(Map<String, dynamic> json) {
    json['groups'].forEach((v) {
      groups!.add(GroupeData.fromJson(v));
    });
  }
}

class GroupeData {
  int? id;
  String? name;
  String? image;
  String? status;
  String? localRegion;
  int? centerId;
  int? keeperId;
  String? deletedAt;

  GroupeData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    status = json['status'];
    localRegion = json['region'];
    centerId = json['center_id'];
    keeperId = json['keeper_id'];
    deletedAt = json['deleted_at'];
  }
}
