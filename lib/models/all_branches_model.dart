class AllBranchesModel {
  List<BranchData>? branches = [];

  AllBranchesModel.fromJson(Map<String, dynamic> json) {
    json['branches'].forEach((v) {
      branches!.add(BranchData.fromJson(v));
    });
  }
}

class BranchData {
  int? id;
  String? name;
  String? image;
  String? status;
  int? supervisorId;
  String? localRegion;
  String? deletedAt;

  BranchData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    status = json['status'];
    supervisorId = json['supervisor_id'];
    localRegion = json['region'];
    deletedAt = json['deleted_at'];
  }
}
