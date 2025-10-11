import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_commerce/app/app_colors.dart';
import 'package:flutter/material.dart';

class ProductImageSlider extends StatefulWidget {
  const ProductImageSlider({super.key, required this.imageUrls});

  final List<String> imageUrls;

  @override
  State<ProductImageSlider> createState() => _ProductImageSliderState();
}

class _ProductImageSliderState extends State<ProductImageSlider> {
  final ValueNotifier<int> _currentIndex = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: 220,
            viewportFraction: 1,
            onPageChanged: (int index, CarouselPageChangedReason reason) {
              _currentIndex.value = index;
            },
          ),
          items: widget.imageUrls.map((image) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    image: DecorationImage(image: NetworkImage(image),
                        fit: BoxFit.scaleDown),
                  ),
                );
              },
            );
          }).toList(),
        ),
        Positioned(
          bottom: 8,
          left: 0,
          right: 0,
          child: ValueListenableBuilder(
            valueListenable: _currentIndex,
            builder: (context, value, child) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (int i = 0; i < widget.imageUrls.length; i++)
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
            },
          ),
        ),
      ],
    );
  }
}
