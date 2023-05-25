class Data {
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
  String? email;
  String? gender;
  String? status;
  String? description;
  String? deletedAt;

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fName = json['fname'];
    sName = json['sname'];
    tName = json['tname'];
    lName = json['lname'];
    identityNo = json['identity_no'];
    phone = json['phone'];
    email = json['email'];
    gender = json['gender'];
    position = json['position'];
    parentId = json['parent_id'];
    status = json['status'];
    localRegion = json['local_region'];
    description = json['description'];
    deletedAt = json['deleted_at'];
  }
}
