import 'package:e_commerce/features/shared/presentation/controllers/category_controller.dart';
import 'package:e_commerce/features/shared/presentation/controllers/main_nav_controller.dart';
import 'package:e_commerce/features/shared/presentation/widgets/centered_circular_progress.dart';
import 'package:e_commerce/features/shared/presentation/widgets/product_category_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryListScreen extends StatefulWidget {
  const CategoryListScreen({super.key});

  @override
  State<CategoryListScreen> createState() => _CategoryListScreenState();
}

class _CategoryListScreenState extends State<CategoryListScreen> {
  final ScrollController _scrollController = ScrollController();
  final CategoryController _categoryController = Get.find<CategoryController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.addListener(_loadMore);
    });
  }

  void _loadMore() {
    if (_scrollController.position.extentAfter < 400) {
      _categoryController.getCategoryList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (_, __) {
        _backToHome();
      } ,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Categories'),
          leading: BackButton(onPressed: _backToHome),
        ),
        body: GetBuilder(
          init: _categoryController,
          builder: (_) {
            if (_categoryController.isInitialLoading) {
              return CenteredCircularProgress();
            }

            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: () async {
                        _categoryController.refreshCategoryList();
                      },
                      child: GridView.builder(
                        controller: _scrollController,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                        ),
                        itemCount: _categoryController.categoryList.length,
                        itemBuilder: (context, index) {
                          return FittedBox(child: ProductCategoryItem(
                            categoryModel: _categoryController
                                .categoryList[index],
                          ));
                        },
                      ),
                    ),
                  ),
                  Visibility(
                      visible: _categoryController.getCategoryInProgress,
                      child: LinearProgressIndicator(),
                  )
                ],
              ),
            );
          }
        ),
      ),
    );
  }

  void _backToHome() {
    Get.find<MainNavController>().backToHome();
  }
}
