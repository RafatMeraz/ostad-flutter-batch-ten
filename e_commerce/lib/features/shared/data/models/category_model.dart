class CategoryModel {
  final String id;
  final String title;
  final String icon;

  CategoryModel({required this.id, required this.title, required this.icon});

  factory CategoryModel.fromJson(Map<String, dynamic> jsonData) {
    return CategoryModel(
      id: jsonData['_id'],
      title: jsonData['title'],
      icon: jsonData['icon'],
    );
  }
}
