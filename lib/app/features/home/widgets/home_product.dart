
import 'package:flutter/material.dart';
import 'package:shopfee/app/config/color.dart';
import 'package:shopfee/app/config/style.dart';
import 'package:shopfee/data/models/product.dart';

class HomeProduct extends StatelessWidget {
  final int index;

  const HomeProduct(this.index, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
      const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment:
        MainAxisAlignment.spaceBetween,
        children: [
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                height: 70,
                width: 70,
                decoration: const BoxDecoration(
                    color: Color(0xfff4f4f3),
                    shape: BoxShape.circle),
              ),
              Image.network(
                Product.products[index].image,
                height: 68,
                width: 58,
              ),
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: 4),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                    BorderRadius.circular(10)),
                child: const Row(
                  crossAxisAlignment:
                  CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.star_rounded,
                      color: Color(0xffFFB800),
                      size: 12,
                    ),
                    SizedBox(
                      width: 2,
                    ),
                    Text(
                      "4.5",
                      style: TextStyle(
                          color: Color(0xff3C3C3C),
                          fontSize: 12,
                          fontWeight:
                          FontWeight.bold),
                    )
                  ],
                ),
              )
            ],
          ),
          Column(
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [
              Text(Product.products[index].name,
                  style: AppStyle.mediumTextStyleDark
                      .copyWith(
                      color: Color(0xff555555))),
              SizedBox(
                height: 4,
              ),
              Text(Product.products[index].descrition,
                  style: AppStyle.normalTextStyleDark
                      .copyWith(
                      color: Color(0xff555555))),
            ],
          ),
          Text(
            Product.products[index].priceString,
            style: AppStyle.mediumTextStyleDark
                .copyWith(
                color: AppColor.headingColor),
          )
        ],
      ),
    );
  }
}