class GetOneCenterModel {
  OneCenterData? center;

  GetOneCenterModel.fromJson(Map<String, dynamic> json) {
    center =
        json['center'] != null ? OneCenterData.fromJson(json['center']) : null;
  }
}

class OneCenterData {
  int? id;
  String? name;
  String? image;
  String? status;
  String? localRegion;
  int? branchId;
  String? deletedAt;

  OneCenterData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    status = json['status'];
    localRegion = json['region'];
    branchId = json['branch_id'];
    deletedAt = json['deleted_at'];
  }
}
