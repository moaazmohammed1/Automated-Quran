class AllReportSupervisorModel {
  List<ReportDataSupervisorModel>? messages = [];

  AllReportSupervisorModel.fromJson(Map<String, dynamic> json) {
    json['messages'].forEach((value) {
      messages!.add(ReportDataSupervisorModel.fromJson(value));
    });
  }
}

class ReportDataSupervisorModel {
  int? id;
  String? fName;
  String? lName;
  String? identityNo;
  String? position;
  String? createdAt;

  ReportDataSupervisorModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fName = json['fname'];
    lName = json['lname'];
    identityNo = json['identity_no'];
    position = json['position'];
    createdAt = json['created_at'];
  }
}
