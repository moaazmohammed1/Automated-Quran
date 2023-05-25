import 'data_model.dart';

class StudentsModel {
  List<Data>? students = [];

  StudentsModel.fromJson(Map<String, dynamic> json) {
    json['students'].forEach((value) {
      students!.add(Data.fromJson(value));
    });
  }
}
