import 'package:e_commerce/features/products/presentation/controllers/product_list_controller.dart';
import 'package:e_commerce/features/shared/data/models/category_model.dart';
import 'package:e_commerce/features/shared/presentation/widgets/centered_circular_progress.dart';
import 'package:e_commerce/features/shared/presentation/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key, required this.category});

  static const String name = '/product-list';

  final CategoryModel category;

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  final ScrollController _scrollController = ScrollController();
  final ProductListController _productListController = ProductListController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_loadMoreData);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _productListController.getProductListByCategory(widget.category.id);
    });
  }

  void _loadMoreData() {
    if (_scrollController.position.extentAfter < 400) {
      _productListController.getProductListByCategory(widget.category.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.category.title)),
      body: GetBuilder(
        init: _productListController,
        builder: (controller) {
          if (controller.isInitialLoading) {
            return CenteredCircularProgress();
          }

          return Column(
            children: [
              Expanded(
                child: GridView.builder(
                  controller: _scrollController,
                  itemCount: controller.productList.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 8,
                  ),
                  itemBuilder: (context, index) {
                    return FittedBox(child: ProductCard(
                        productModel: controller.productList[index]
                    ));
                  },
                ),
              ),
              Visibility(
                visible: controller.getProductsInProgress,
                child: LinearProgressIndicator(),
              ),
            ],
          );
        },
      ),
    );
  }
}
