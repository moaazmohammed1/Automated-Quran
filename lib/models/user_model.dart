class UserModel {
  String? message;
  UserData? admin;

  UserModel.fromJson(Map<String, dynamic> json) {
    message = json['message'] ?? '';
    admin = json['admin'] != null ? UserData.fromJson(json['admin']) : null;
  }
}

class UserData {
  int? id;
  String? fName;
  String? sName;
  String? tName;
  String? lName;
  String? identityNo;
  String? phone;
  String? email;
  String? gender;
  String? password;
  String? status;
  String? localRegion;
  String? description;

  UserData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fName = json['fname'];
    sName = json['sname'];
    tName = json['tname'];
    lName = json['lname'];
    identityNo = json['identity_no'];
    phone = json['phone'];
    email = json['email'];
    gender = json['gender'];
    password = json['password'];
    status = json['status'];
    localRegion = json['local_region'];
    description = json['description'];
  }
}
