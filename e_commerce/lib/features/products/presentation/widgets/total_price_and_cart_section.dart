import 'package:e_commerce/app/controllers/auth_controller.dart';
import 'package:e_commerce/features/auth/presentation/screens/sign_in_screen.dart';
import 'package:e_commerce/features/products/presentation/controllers/add_to_cart_controller.dart';
import 'package:e_commerce/features/shared/data/models/product_details_model.dart';
import 'package:e_commerce/features/shared/data/models/product_model.dart';
import 'package:e_commerce/features/shared/presentation/widgets/centered_circular_progress.dart';
import 'package:e_commerce/features/shared/presentation/widgets/snack_bar_message.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../app/app_colors.dart';
import '../../../../app/constants.dart';

class TotalPriceAndCartSection extends StatefulWidget {
  const TotalPriceAndCartSection({super.key, required this.productModel});

  final ProductDetailsModel productModel;

  @override
  State<TotalPriceAndCartSection> createState() =>
      _TotalPriceAndCartSectionState();
}

class _TotalPriceAndCartSectionState extends State<TotalPriceAndCartSection> {
  final AddToCartController _cartController = AddToCartController();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.themeColor.withOpacity(0.1),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Price',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                '$takaSign${widget.productModel.currentPrice}',
                style: textTheme.titleMedium?.copyWith(
                  color: AppColors.themeColor,
                ),
              ),
            ],
          ),
          GetBuilder(
            init: _cartController,
            builder: (controller) {
              return SizedBox(
                width: 120,
                child: Visibility(
                  visible: controller.addToCartInProgress == false,
                  replacement: CenteredCircularProgress(),
                  child: FilledButton(
                    onPressed: _onTapAddToCardButton,
                    child: Text('Add to Cart'),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Future<void> _onTapAddToCardButton() async {
    if (await Get.find<AuthController>().isUserAlreadyLoggedIn()) {
      final bool isSuccess = await _cartController.addToCart(
          widget.productModel.id);
      if (isSuccess) {
        showSnackBarMessage(context, 'Added to cart');
      } else {
        showSnackBarMessage(context, _cartController.errorMessage!);
      }
    } else {
      Navigator.pushNamed(context, SignInScreen.name);
    }
  }
}
