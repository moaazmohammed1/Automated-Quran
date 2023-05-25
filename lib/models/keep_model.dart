class KeepModel {
  KeepData? keeps;
  KeepModel.fromJson(Map<String, dynamic> json) {
    keeps = json['keeps'] != null ? KeepData.fromJson(json['keeps']) : null;
  }
}

class KeepData {
  List<KeepDataModel>? data = [];

  KeepData.fromJson(Map<String, dynamic> json) {
    json['data'].forEach((value) {
      data!.add(KeepDataModel.fromJson(value));
    });
  }
}

class KeepDataModel {
  int? id;
  int? fromJuz;
  int? toJuz;
  int? fromSurah;
  int? toSurah;
  int? fromAyah;
  int? toAyah;
  int? faults;
  int? studentId;
  int? groupId;
  String? dayEnName;
  String? dayArName;
  String? createdAt;

  KeepDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fromJuz = json['from_juz'];
    toJuz = json['to_juz'];
    fromSurah = json['from_surah'];
    toSurah = json['to_surah'];
    fromAyah = json['from_ayah'];
    toAyah = json['to_ayah'];
    faults = json['faults'];
    studentId = json['student_id'];
    groupId = json['group_id'];
    createdAt = json['created_at'];
    dayEnName = json['day_en_name'];
    dayArName = json['day_ar_name'];
  }
}
