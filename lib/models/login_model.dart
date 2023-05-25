class LoginModel {
  String? token;
  DataLoginModel? user;

  LoginModel.fromJson(Map<String, dynamic> json) {
    token = json['_token'];
    user = json['user'] != null ? DataLoginModel.fromJson(json['user']) : null;
  }
}

class DataLoginModel {
  int? id;
  String? fName;
  String? sName;
  String? tName;
  String? lName;
  String? identityNo;
  String? phone;
  String? email;
  String? gender;
  String? status;
  String? localRegion;
  String? description;
  String? position;

  DataLoginModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fName = json['fname'];
    sName = json['sname'];
    tName = json['tname'];
    lName = json['lname'];
    identityNo = json['identity_no'];
    phone = json['phone'];
    email = json['email'];
    gender = json['gender'];
    status = json['status'];
    localRegion = json['local_region'];
    description = json['description'];
    position = json['position'];
  }
}
