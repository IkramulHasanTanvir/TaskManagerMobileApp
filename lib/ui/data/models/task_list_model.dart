import 'package:task_manager_mobile_app/ui/data/models/task_model.dart';

class TaskListModel {
  String? status;
  List<TaskModel>? taskList;

  TaskListModel({this.status, this.taskList});

  TaskListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      taskList = <TaskModel>[];
      json['data'].forEach((v) {
        taskList!.add(TaskModel.fromJson(v));
      });
    }
  }
}

