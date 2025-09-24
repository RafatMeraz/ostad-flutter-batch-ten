import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_commerce/app/app_colors.dart';
import 'package:e_commerce/features/home/data/models/home_slider.dart';
import 'package:flutter/material.dart';

class HomeBannerSlider extends StatefulWidget {
  const HomeBannerSlider({super.key, required this.sliders});

  final List<HomeSlider> sliders;

  @override
  State<HomeBannerSlider> createState() => _HomeBannerSliderState();
}

class _HomeBannerSliderState extends State<HomeBannerSlider> {
  final ValueNotifier<int> _currentIndex = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 4,
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: 180,
            viewportFraction: 1,
            onPageChanged: (int index, CarouselPageChangedReason reason) {
              _currentIndex.value = index;
            },
          ),
          items: widget.sliders.map((slider) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: BoxDecoration(
                    color: AppColors.themeColor,
                    borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(image: NetworkImage(
                          slider.photoUrl), fit: BoxFit.cover)
                  ),
                  alignment: Alignment.center,
                );
              },
            );
          }).toList(),
        ),
        ValueListenableBuilder(
          valueListenable: _currentIndex,
          builder: (context, value, child) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 0; i < widget.sliders.length; i++)
                  Container(
                    width: 12,
                    height: 12,
                    margin: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: value == i ? AppColors.themeColor : null,
                      border: Border.all(color: Colors.grey),
                    ),
                  ),
              ],
            );
          }
        ),
      ],
    );
  }
}
