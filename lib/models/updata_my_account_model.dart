class UpdateMyAccountModel {
  String? message;
  DataMyAccountModel? user;
}


class DataMyAccountModel {
  int? id;
  String? fName;
  String? sName;
  String? tName;
  String? lName;
  String? identityNo;
  String? phone;
  String? localRegion;
  String? position;
  String? gender;
  String? status;
  String? email;
  String? description;
  String? deletedAt;

  DataMyAccountModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fName = json['fname'];
    sName = json['sname'];
    tName = json['tname'];
    lName = json['lname'];
    identityNo = json['identity_no'];
    phone = json['phone'];
    localRegion = json['local_region'];
    position = json['position'];
    gender = json['gender'];
    status = json['status'];
    email = json['email'];
    description = json['description'];
    deletedAt = json['deleted_at'];
  }
}
