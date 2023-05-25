class GetOneBranchModel {
  OneBranchData? branch;

  GetOneBranchModel.fromJson(Map<String, dynamic> json) {
    branch =
        json['branch'] != null ? OneBranchData.fromJson(json['branch']) : null;
  }
}

class OneBranchData {
  int? id;
  String? name;
  String? image;
  String? status;
  int? supervisorId;
  String? localRegion;
  String? deletedAt;

  OneBranchData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    status = json['status'];
    supervisorId = json['supervisor_id'];
    localRegion = json['region'];
    deletedAt = json['deleted_at'];
  }
}
