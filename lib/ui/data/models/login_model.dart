import 'package:task_manager_mobile_app/ui/data/models/user_model.dart';

class UserLoginModel {
  String? status;
  List<UserModel>? data;

  UserLoginModel({this.status, this.data});

  UserLoginModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <UserModel>[];
      json['data'].forEach((v) {
        data!.add(UserModel.fromJson(v));
      });
    }
  }
}



