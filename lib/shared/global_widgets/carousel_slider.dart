import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CarouselSliderWidget extends StatelessWidget {
  final List<Widget> items;
  final double height;
  final Function(int, CarouselPageChangedReason)? onPageChanged;
  const CarouselSliderWidget({super.key, required this.items, this.onPageChanged, required this.height});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
        items: items,
        options: CarouselOptions(
          height: height,
          aspectRatio: 16/9,
          viewportFraction: 1,
          initialPage: 0,
          enableInfiniteScroll: true,
          reverse: false,
          autoPlay: true,
          autoPlayInterval: Duration(seconds: 2),
          autoPlayAnimationDuration: Duration(milliseconds: 500),
          autoPlayCurve: Curves.fastOutSlowIn,
          enlargeCenterPage: true,
          enlargeFactor: 0.3,
          onPageChanged: onPageChanged,
          scrollDirection: Axis.horizontal,
        )
    );
  }
}
