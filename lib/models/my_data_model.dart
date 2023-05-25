class MyDataModel {
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
  String? position;
  String? localRegion;
  String? description;

  MyDataModel.fromJson(Map<String, dynamic> json) {
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
    position = json['position'];
    status = json['status'];
  }
}
