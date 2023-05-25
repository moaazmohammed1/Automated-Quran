import 'data_model.dart';

class KeepersModel {
  List<Data>? keepers = [];

  KeepersModel.fromJson(Map<String, dynamic> json) {
    json['keepers'].forEach((value) {
      keepers!.add(Data.fromJson(value));
    });
  }
}
