class GetMyTestsModel {
  List<TestDataModel>? tests = [];

  GetMyTestsModel.fromJson(Map<String, dynamic> json) {
    if (json['tests'] != null) {
      json['tests'].forEach((v) {
        tests!.add(TestDataModel.fromJson(v));
      });
    }
  }
}

class TestDataModel {
  int? id;
  String? type;
  int? from;
  int? to;
  int? keeperId;
  int? studentId;
  int? mark;
  String? createdAt;

  TestDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    from = json['from'];
    to = json['to'];
    keeperId = json['keeper_id'];
    studentId = json['student_id'];
    mark = json['mark'];
    createdAt = json['created_at'];
  }
}
