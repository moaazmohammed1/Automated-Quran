class TestModel {
  int? testId;
  List<Question>? questions = [];

  TestModel.fromJson(Map<String, dynamic> json) {
    testId = json['test_id'];
    if (json['questions'] != null) {
      json['questions'].forEach((v) {
        questions!.add(Question.fromJson(v));
      });
    }
  }
}

class Question {
  String? text;
  SurahQuestion? surah;

  Question.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    surah = SurahQuestion.fromJson(json['surah']);
  }
}

class SurahQuestion {
  String? name;

  SurahQuestion.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }
}
