class AllCenterModel {
  List<CenterData>? centers = [];

  AllCenterModel.fromJson(Map<String, dynamic> json) {
    json['centers'].forEach((v) {
      centers!.add(CenterData.fromJson(v));
    });
  }
}

class CenterData {
  int? id;
  String? name;
  String? image;
  String? status;
  String? localRegion;
  int? branchId;
  String? deletedAt;

  CenterData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    status = json['status'];
    localRegion = json['region'];
    branchId = json['branch_id'];
    deletedAt = json['deleted_at'];
  }
}
