class Urls {
  static const String _baseurl = 'http://152.42.163.176:2006/api/v1';

  static const String login = '$_baseurl/Login';

  static const String registration = '$_baseurl/Registration';

  static const String profileUpdate = '$_baseurl/ProfileUpdate';

  static const String createTask = '$_baseurl/createTask';

  static const String newTaskList = '$_baseurl/listTaskByStatus/New';

  static const String completedTaskList =
      '$_baseurl/listTaskByStatus/Completed';

  static const String canceledTaskList = '$_baseurl/listTaskByStatus/Canceled';

  static const String progressTaskList = '$_baseurl/listTaskByStatus/Progress';

  static const String deleteTask = '$_baseurl/deleteTask';

  static const String updateTaskStatus = '$_baseurl/updateTaskStatus';
}
