import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CarouselSliderWidget extends StatelessWidget {
  final List<Widget> items;
  final double height;
  final double viewportFraction;
  final bool enLargeCenter;
  final bool infiniteScroll;
  final bool reverse;
  final bool autoPlay;
  final Function(int, CarouselPageChangedReason)? onPageChanged;
  const CarouselSliderWidget({super.key, required this.items, this.onPageChanged, required this.height, required this.viewportFraction,this.enLargeCenter=true, this.infiniteScroll=true, this.reverse=false, this.autoPlay=true});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
        items: items,
        options: CarouselOptions(
          height: height,
          aspectRatio: 16/9,
          viewportFraction: viewportFraction,
          initialPage: 0,
          enableInfiniteScroll: infiniteScroll,
          reverse: reverse,
          autoPlay: autoPlay,
          autoPlayInterval: Duration(seconds: 2),
          autoPlayAnimationDuration: Duration(milliseconds: 500),
          autoPlayCurve: Curves.fastOutSlowIn,
          enlargeCenterPage: enLargeCenter,
          enlargeFactor: 0.3,
          onPageChanged: onPageChanged,
          scrollDirection: Axis.horizontal,
          padEnds: false
        )
    );
  }
}
