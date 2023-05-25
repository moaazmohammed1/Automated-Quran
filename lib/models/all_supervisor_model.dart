import 'data_model.dart';
class SupervisorModel {
  List<Data>? supervisors = [];

  SupervisorModel.fromJson(Map<String, dynamic> json) {
    json['supervisors'].forEach((value) {
      supervisors!.add(Data.fromJson(value));
    });
  }
}
