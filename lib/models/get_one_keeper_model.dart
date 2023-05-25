class GetOneKeeperModel {
  OneKeeperData? keeper;

  GetOneKeeperModel.fromJson(Map<String, dynamic> json) {
    keeper =
        json['keeper'] != null ? OneKeeperData.fromJson(json['keeper']) : null;
  }
}

class OneKeeperData {
  int? id;
  String? fName;
  String? sName;
  String? tName;
  String? lName;
  String? identityNo;
  String? phone;
  int? parentId;
  String? localRegion;
  String? position;
  String? gender;
  String? status;
  String? email;
  String? description;

  OneKeeperData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fName = json['fname'];
    sName = json['sname'];
    tName = json['tname'];
    lName = json['lname'];
    identityNo = json['identity_no'];
    phone = json['phone'];
    email = json['email'];
    gender = json['gender'];
    parentId = json['parent_id'];
    status = json['status'];
    localRegion = json['local_region'];
    description = json['description'];
  }
}
