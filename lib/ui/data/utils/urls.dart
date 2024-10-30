class Urls {
  static const String _baseurl = 'http://35.73.30.144:2005/api/v1';

  static const String login = '$_baseurl/Login';

  static const String registration = '$_baseurl/Registration';

  static const String profileUpdate = '$_baseurl/ProfileUpdate';

  static const String createTask = '$_baseurl/createTask';

  static const String newTaskList = '$_baseurl/listTaskByStatus/New';

  static const String completedTaskList =
      '$_baseurl/listTaskByStatus/Completed';

  static const String canceledTaskList = '$_baseurl/listTaskByStatus/Canceled';

  static const String progressTaskList = '$_baseurl/listTaskByStatus/Progress';

  static const String taskListCount = '$_baseurl/taskStatusCount';

  static String deleteTask(String taskId) => '$_baseurl/deleteTask/$taskId';

  static String updateTaskStatus(String taskId, String status) =>
      '$_baseurl/updateTaskStatus/$taskId/$status';
}
