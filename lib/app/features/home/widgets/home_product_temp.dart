
import 'package:flutter/material.dart';
import 'package:shopfee/app/config/color.dart';
import 'package:shopfee/app/config/style.dart';
import 'package:shopfee/data/models/product_temp.dart';

class HomeProductTemp extends StatelessWidget {
  final ProductTemp product;

  const HomeProductTemp(this.product, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
      const EdgeInsets.symmetric(vertical: 8.0),
      child: InkWell(
        onTap: (){
          // Navigator.push(context, MaterialPageRoute(builder: (context) => ProductScreen(product)));
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
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
                // Container(
                //   padding: EdgeInsets.symmetric(
                //       horizontal: 4),
                //   decoration: BoxDecoration(
                //       color: Colors.white,
                //       borderRadius:
                //       BorderRadius.circular(10)),
                //   child: const Row(
                //     crossAxisAlignment:
                //     CrossAxisAlignment.center,
                //     children: [
                //       Icon(
                //         Icons.star_rounded,
                //         color: Color(0xffFFB800),
                //         size: 12,
                //       ),
                //       SizedBox(
                //         width: 2,
                //       ),
                //       Text(
                //         "4.5",
                //         style: TextStyle(
                //             color: Color(0xff3C3C3C),
                //             fontSize: 12,
                //             fontWeight:
                //             FontWeight.bold),
                //       )
                //     ],
                //   ),
                // )
              ],
            ),
            const SizedBox(width: 20,),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    Text(product.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppStyle.mediumTextStyleDark
                            .copyWith(
                            color: const Color(0xff555555))),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(product.description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: AppStyle.normalTextStyleDark
                            .copyWith(
                            color: const Color(0xff555555))),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 20,),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                product.priceString,
                style: AppStyle.mediumTextStyleDark
                    .copyWith(
                    color: AppColor.headingColor),
              ),
            )
          ],
        ),
      ),
    );
  }
}