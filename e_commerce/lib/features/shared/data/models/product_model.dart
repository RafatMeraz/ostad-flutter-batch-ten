class ProductModel {
  final String id;
  final String title;
  final List<String> photos;
  final int currentPrice;
  final double rating;

  ProductModel({
    required this.id,
    required this.title,
    required this.photos,
    required this.currentPrice,
    required this.rating,
  });

  factory ProductModel.fromJson(Map<String, dynamic> jsonData) {
    return ProductModel(
      id: jsonData['_id'],
      title: jsonData['title'],
      photos: List<String>.from(jsonData['photos'].map((e) => e).toList()),
      currentPrice: jsonData['current_price'],
      rating: 2.0,
    );
  }
}
