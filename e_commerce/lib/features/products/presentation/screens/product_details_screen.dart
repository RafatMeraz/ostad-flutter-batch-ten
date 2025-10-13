import 'package:e_commerce/app/app_colors.dart';
import 'package:e_commerce/features/products/presentation/controllers/product_details_controller.dart';
import 'package:e_commerce/features/products/presentation/widgets/color_picker.dart';
import 'package:e_commerce/features/products/presentation/widgets/product_image_slider.dart';
import 'package:e_commerce/features/products/presentation/widgets/size_picker.dart';
import 'package:e_commerce/features/shared/presentation/widgets/centered_circular_progress.dart';
import 'package:e_commerce/features/shared/presentation/widgets/inc_dec_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/total_price_and_cart_section.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key, required this.productId});

  static const String name = '/product-details';

  final String productId;

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  final ProductDetailsController _productDetailsController =
      ProductDetailsController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _productDetailsController.getProductDetails(widget.productId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: Text('Product Details')),
      body: GetBuilder(
        init: _productDetailsController,
        builder: (controller) {
          if (controller.getProductDetailsInProgress) {
            return CenteredCircularProgress();
          }

          if (controller.errorMessage != null) {
            return Center(child: Text(controller.errorMessage!));
          }

          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ProductImageSlider(
                        imageUrls: controller.productDetails?.photos ?? [],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              spacing: 8,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        controller.productDetails?.title ?? '',
                                        style: textTheme.bodyLarge?.copyWith(
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Wrap(
                                            children: [
                                              Icon(
                                                Icons.star,
                                                size: 24,
                                                color: Colors.amber,
                                              ),
                                              Text(
                                                controller
                                                        .productDetails
                                                        ?.rating ??
                                                    '',
                                                style: TextStyle(fontSize: 18),
                                              ),
                                            ],
                                          ),
                                          TextButton(
                                            onPressed: () {},
                                            child: Text('Reviews'),
                                          ),
                                          Card(
                                            color: AppColors.themeColor,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(2),
                                              child: Icon(
                                                Icons.favorite_outline,
                                                size: 18,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 80,
                                  child: IncDecButton(onChange: (int value) {}),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Visibility(
                              visible: (controller.productDetails?.colors ?? [])
                                  .isNotEmpty,
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 12),
                                child: Text(
                                  'Color',
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            ColorPicker(
                              colors: controller.productDetails?.colors ?? [],
                              onSelected: (String color) {},
                            ),
                            const SizedBox(height: 16),
                            Visibility(
                              visible: (controller.productDetails?.sizes ?? [])
                                  .isNotEmpty,
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 12),
                                child: Text(
                                  'Size',
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                            ),
                            SizePicker(
                              sizes: controller.productDetails?.sizes ?? [],
                              onSelected: (String size) {},
                            ),
                            const SizedBox(height: 16),
                            Text('Description', style: TextStyle(fontSize: 18)),
                            Text(
                              controller.productDetails?.description ?? '',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              TotalPriceAndCartSection(
                productModel: controller.productDetails!,
              ),
            ],
          );
        },
      ),
    );
  }
}
