import 'package:e_commerce/features/shared/data/models/product_model.dart';

class CartItemModel {
  final String id;
  final ProductModel product;
  int quantity;
  String? color;
  String? size;

  CartItemModel({
    required this.id,
    required this.product,
    required this.quantity,
    required this.color,
    required this.size,
  });

  factory CartItemModel.fromJson(Map<String, dynamic> jsonData) {
    return CartItemModel(
      id: jsonData['_id'],
      product: ProductModel.fromJson(jsonData['product']),
      quantity: jsonData['quantity'],
      color: jsonData['color'],
      size: jsonData['size'],
    );
  }
}
