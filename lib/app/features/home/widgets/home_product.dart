
import 'package:flutter/material.dart';
import 'package:shopfee/app/config/color.dart';
import 'package:shopfee/app/config/style.dart';
import 'package:shopfee/app/features/product/screen/product_screen.dart';
import 'package:shopfee/data/models/product.dart';

class HomeProduct extends StatelessWidget {
  final Product product;

  const HomeProduct(this.product, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
      const EdgeInsets.symmetric(vertical: 8.0),
      child: InkWell(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => ProductScreen(product)));
        },
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
                  product.image,
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
                Text(product.name,
                    style: AppStyle.mediumTextStyleDark
                        .copyWith(
                        color: Color(0xff555555))),
                SizedBox(
                  height: 4,
                ),
                Text(product.description,
                    style: AppStyle.normalTextStyleDark
                        .copyWith(
                        color: Color(0xff555555))),
              ],
            ),
            Text(
              product.priceString,
              style: AppStyle.mediumTextStyleDark
                  .copyWith(
                  color: AppColor.headingColor),
            )
          ],
        ),
      ),
    );
  }
}