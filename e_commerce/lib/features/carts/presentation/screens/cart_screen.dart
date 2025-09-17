import 'package:e_commerce/app/app_colors.dart';
import 'package:e_commerce/app/asset_paths.dart';
import 'package:e_commerce/features/carts/presentation/widgets/total_price_and_checkout_section.dart';
import 'package:e_commerce/features/shared/presentation/widgets/inc_dec_button.dart';
import 'package:flutter/material.dart';

import '../../../../app/constants.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cart')),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              itemCount: 5,
              itemBuilder: (context, index) {
                return Card(
                  color: Colors.white,
                  elevation: 4,
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  shadowColor: AppColors.themeColor.withOpacity(0.3),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.all(4),
                        decoration: BoxDecoration(),
                        child: Image.asset(
                          AssetPaths.dummyImagePng,
                          height: 80,
                          width: 80,
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Nike Shoe - 2025 Edition',
                                          style: TextTheme.of(context).titleSmall,
                                        ),
                                        Text(
                                          'Size: XL  Color: Red',
                                          style: TextTheme.of(context).bodySmall,
                                        ),
                                      ],
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {},
                                    icon: Icon(Icons.delete_forever_outlined),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '${takaSign}1000',
                                    style: TextTheme.of(context).titleSmall?.copyWith(
                                      color: AppColors.themeColor,
                                    ),
                                  ),
                                  IncDecButton(onChange: (int value) {})
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return SizedBox(height: 8);
              },
            ),
          ),
          TotalPriceAndCheckoutSection(),
        ],
      ),
    );
  }
}
