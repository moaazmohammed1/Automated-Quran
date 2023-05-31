class AllReportKeeperModel {
  List<ReportDataModel>? reports = [];

  AllReportKeeperModel.fromJson(Map<String, dynamic> json) {
    json['reports'].forEach((value) {
      reports!.add(ReportDataModel.fromJson(value));
    });
  }
}

class ReportDataModel {
  int? id;
  int? keeperId;
  String? status;
  String? type;
  String? payload;
  String? submittedMsg;
  String? createdAt;

  ReportDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    keeperId = json['keeper_id'];
    status = json['status'];
    type = json['type'];
    payload = json['payload'];
    submittedMsg = json['submitted_msg'];
    createdAt = json['created_at'];
  }
}
