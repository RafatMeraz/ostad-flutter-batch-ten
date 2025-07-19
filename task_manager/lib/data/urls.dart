class Urls {
  static const String _baseUrl = 'http://35.73.30.144:2005/api/v1';

  static const String registrationUrl = '$_baseUrl/Registration';
  static const String loginUrl = '$_baseUrl/Login';
  static const String createNewTaskUrl = '$_baseUrl/createTask';
  static const String getNewTasksUrl = '$_baseUrl/listTaskByStatus/New';
  static const String getProgressTasksUrl = '$_baseUrl/listTaskByStatus/Progress';
  static const String getTaskStatusCountUrl = '$_baseUrl/taskStatusCount';

  static String updateTaskStatusUrl(String taskId, String status) =>
      '$_baseUrl/updateTaskStatus/$taskId/$status';

  static const String updateProfileUrl = '$_baseUrl/ProfileUpdate';
}