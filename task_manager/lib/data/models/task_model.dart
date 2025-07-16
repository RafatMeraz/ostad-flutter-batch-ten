class TaskModel {
  late String id;
  late String title;
  late String description;
  late String status;
  late String createdDate;

  TaskModel.fromJson(Map<String, dynamic> jsonData) {
    id = jsonData['_id'];
    title = jsonData['title'];
    description = jsonData['description'];
    status = jsonData['status'];
    createdDate = jsonData['createdDate'];
  }
}
