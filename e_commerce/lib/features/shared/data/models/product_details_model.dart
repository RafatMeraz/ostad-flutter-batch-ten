class ProductDetailsModel {
  final String id;
  final String title;
  final String description;
  final List<String> photos;
  final List<String> colors;
  final List<String> sizes;
  final int currentPrice;
  final String rating = '4.3';

  ProductDetailsModel({
    required this.id,
    required this.title,
    required this.description,
    required this.photos,
    required this.colors,
    required this.sizes,
    required this.currentPrice,
  });

  factory ProductDetailsModel.fromJson(Map<String, dynamic> jsonData) {
    return ProductDetailsModel(
      id: jsonData['_id'],
      title: jsonData['title'],
      description: jsonData['description'],
      photos: List<String>.from(jsonData['photos'].map((e) => e).toList()),
      colors: List<String>.from(jsonData['colors'].map((e) => e).toList()),
      sizes: List<String>.from(jsonData['sizes'].map((e) => e).toList()),
      currentPrice: jsonData['current_price'],
    );
  }
}
