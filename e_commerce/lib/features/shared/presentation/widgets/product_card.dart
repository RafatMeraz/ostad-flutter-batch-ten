import 'package:e_commerce/features/products/presentation/screens/product_details_screen.dart';
import 'package:e_commerce/features/shared/data/models/product_model.dart';
import 'package:flutter/material.dart';

import '../../../../app/app_colors.dart';
import '../../../../app/asset_paths.dart';
import '../../../../app/constants.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.productModel});

  final ProductModel productModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
            context, ProductDetailsScreen.name, arguments: productModel.id);
      },
      child: Card(
        color: Colors.white,
        shadowColor: AppColors.themeColor.withOpacity(0.2),
        child: SizedBox(
          width: 140,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.themeColor.withOpacity(0.1),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                  ),
                ),
                child: Image.network(
                  productModel.photos.firstOrNull ?? '',
                  width: 140,
                  height: 80,
                  errorBuilder: (_, __, ___) {
                    return SizedBox(
                      width: 140,
                      height: 80,
                      child: Icon(
                        Icons.error_outline,
                        size: 48,
                        color: Colors.grey,
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 4,
                  children: [
                    Text(
                      productModel.title,
                      maxLines: 1,
                      style: TextStyle(overflow: TextOverflow.ellipsis),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '$takaSign${productModel.currentPrice}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.themeColor,
                          ),
                        ),
                        Wrap(
                          children: [
                            Icon(Icons.star, size: 18, color: Colors.amber),
                            Text(productModel.rating.toString()),
                          ],
                        ),
                        Card(
                          color: AppColors.themeColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(2),
                            child: Icon(
                              Icons.favorite_outline,
                              size: 14,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
