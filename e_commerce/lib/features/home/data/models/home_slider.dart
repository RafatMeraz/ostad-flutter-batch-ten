class HomeSlider {
  final String id;
  final String photoUrl;
  final String description;
  final String brandId;

  HomeSlider({
    required this.id,
    required this.photoUrl,
    required this.description,
    required this.brandId,
  });

  factory HomeSlider.fromJson(Map<String, dynamic> jsonData) {
    return HomeSlider(
      id: jsonData['_id'],
      photoUrl: jsonData['photo_url'],
      description: jsonData['description'],
      brandId: jsonData['brand'],
    );
  }
}
