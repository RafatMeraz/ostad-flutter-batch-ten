import 'package:e_commerce/app/asset_paths.dart';
import 'package:e_commerce/features/shared/presentation/controllers/category_controller.dart';
import 'package:e_commerce/features/shared/presentation/controllers/main_nav_controller.dart';
import 'package:e_commerce/features/shared/presentation/widgets/centered_circular_progress.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../shared/presentation/widgets/product_card.dart';
import '../../../shared/presentation/widgets/product_category_item.dart';
import '../controllers/home_slider_controller.dart';
import '../widgets/app_bar_icon_button.dart';
import '../widgets/home_banner_slider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: SvgPicture.asset(AssetPaths.logoNavSvg),
        actions: [
          AppBarIconButton(onTap: () {}, iconData: Icons.person),
          AppBarIconButton(onTap: () {}, iconData: Icons.call),
          AppBarIconButton(
            onTap: () {},
            iconData: Icons.notifications_on_outlined,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const SizedBox(height: 16),
              _buildSearchBar(),
              const SizedBox(height: 16),
              GetBuilder<HomeSliderController>(
                builder: (controller) {
                  if (controller.getSlidersInProgress) {
                    return SizedBox(
                        height: 180,
                        child: CenteredCircularProgress());
                  }
                  return HomeBannerSlider(sliders: controller.sliders);
                }
              ),
              const SizedBox(height: 16),
              _buildSectionHeader(
                title: 'Categories',
                onTapSeeAll: () {
                  Get.find<MainNavController>().moveToCategory();
                },
              ),
              _buildCategoryList(),
              _buildSectionHeader(title: 'New', onTapSeeAll: () {}),
              _buildNewProductList(),
              _buildSectionHeader(title: 'Special', onTapSeeAll: () {}),
              _buildSpecialProductList(),
              _buildSectionHeader(title: 'Popular', onTapSeeAll: () {}),
              _buildPopularProductList()
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryList() {
    return SizedBox(
      height: 100,
      child: GetBuilder<CategoryController>(
        builder: (controller) {
          if (controller.isInitialLoading) {
            return CenteredCircularProgress();
          }
          return ListView.separated(
            itemCount: controller.categoryList.length > 10 ? 10 : controller
                .categoryList.length,
            primary: false,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return ProductCategoryItem(
                categoryModel: controller.categoryList[index],
              );
            },
            separatorBuilder: (context, index) {
              return SizedBox(width: 10);
            },
          );
        }
      ),
    );
  }

  Widget _buildNewProductList() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        // children: [1, 2, 3, 4, 56].map((e) => ProductCard()).toList(),
      ),
    );
  }

  Widget _buildPopularProductList() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        // children: [1, 2, 3, 4, 56].map((e) => ProductCard()).toList(),
      ),
    );
  }

  Widget _buildSpecialProductList() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        // children: [1, 2, 3, 4, 56].map((e) => ProductCard()).toList(),
      ),
    );
  }

  Widget _buildSectionHeader({
    required String title,
    required VoidCallback onTapSeeAll,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: Theme.of(context).textTheme.titleMedium),
        TextButton(onPressed: onTapSeeAll, child: Text('See all')),
      ],
    );
  }

  Widget _buildSearchBar() {
    return TextField(
      onSubmitted: (String? text) {},
      textInputAction: TextInputAction.search,
      decoration: InputDecoration(
        hintText: 'Search',
        fillColor: Colors.grey.shade100,
        filled: true,
        enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
        focusedBorder: OutlineInputBorder(borderSide: BorderSide.none),
        prefixIcon: Icon(Icons.search),
      ),
    );
  }
}