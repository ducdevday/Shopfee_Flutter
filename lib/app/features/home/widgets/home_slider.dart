import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:shopfee/app/common/data/global_data.dart';
import 'package:shopfee/app/config/color.dart';

class HomeSlider extends StatefulWidget {
  const HomeSlider({Key? key}) : super(key: key);

  @override
  State<HomeSlider> createState() => _HomeSliderState();
}

class _HomeSliderState extends State<HomeSlider> {
  int _current = 0;
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      CarouselSlider(
          items: GlobalData.ins.imgList
              .map((item) => Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: Center(
                child: Image.network(item,
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width - 20)),
          ))
              .toList(),
          carouselController: _controller,
          options: CarouselOptions(
            height: 137,
            viewportFraction: 0.9,
            initialPage: 0,
            enableInfiniteScroll: false,
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
              });
            },
          )),
      Positioned.fill(
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            margin: const EdgeInsets.only(bottom: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: GlobalData.ins.imgList.asMap().entries.map((entry) {
                return GestureDetector(
                  onTap: () => _controller.animateToPage(entry.key),
                  child: Container(
                    width: 12.0,
                    height: 12.0,
                    margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _current == entry.key ? AppColor.primaryColor : Colors.white),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ),
    ],);
  }
}
