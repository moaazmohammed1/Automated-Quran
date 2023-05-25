class AttendanceModel {
  int? absenceDays;
  int? attendanceDays;
  int? remainingDays;
  List<AttendanceDayModel>? all = [];

  AttendanceModel.fromJson(Map<String, dynamic> json) {
    absenceDays = json['absenceDays'];
    attendanceDays = json['attendanceDays'];
    remainingDays = json['remainingDays'];

    json['all'].forEach((v) {
      all!.add(AttendanceDayModel.fromJson(v));
    });
  }
}

class AttendanceDayModel {
  int? id;
  int? userId;
  String? absenceType;
  String? absenceDate;
  // int? report;
  int? status;
  String? dayEnName;
  String? dayArName;

  AttendanceDayModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    absenceType = json['absence_type'];
    absenceDate = json['absence_date'];
    status = json['status'];
    dayEnName = json['day_en_name'];
    dayArName = json['day_ar_name'];
  }
}
