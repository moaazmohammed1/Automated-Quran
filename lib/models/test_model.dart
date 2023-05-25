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
