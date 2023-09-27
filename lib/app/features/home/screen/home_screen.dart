import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:shopfee/app/common/data/global_data.dart';
import 'package:shopfee/app/common/widgets/my_bottom_navigationbar.dart';
import 'package:shopfee/app/config/color.dart';
import 'package:shopfee/app/config/dimens.dart';
import 'package:shopfee/app/config/style.dart';
import 'package:shopfee/app/features/home/widgets/home_filter.dart';
import 'package:shopfee/app/features/home/widgets/home_product.dart';
import 'package:shopfee/app/features/home/widgets/home_slider.dart';
import 'package:shopfee/data/models/product.dart';

class HomeScreen extends StatelessWidget {
  final MyBottomNavigationBar myBottomNavigationBar;

  const HomeScreen(this.myBottomNavigationBar, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (BuildContext context, bool isScrolled) {
          return [
            SliverAppBar(
              snap: true,
              automaticallyImplyLeading: false,
              floating: true,
              title: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, "/search");
                        },
                        child: TextField(
                          enabled: false,
                          style: AppStyle.smallTextStyleDark,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(8),
                            suffixIcon: const Icon(Icons.search),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16)),
                            hintText: "What would you like to drink today?",
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Icon(Icons.notifications_none_outlined)
                  ],
                ),
              ),
              bottom: const PreferredSize(
                preferredSize: Size.fromHeight(1),
                child: Divider(height: 1),
              ),
            )
          ];
        },
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              const HomeSlider(),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppDimen.screenPadding),
                child: DefaultTabController(
                    length: 3,
                    child: Column(
                      children: [
                        TabBar(
                          unselectedLabelColor: AppColor.disableColor,
                          indicatorColor: AppColor.primaryColor,
                          labelColor: AppColor.primaryColor,
                          tabs: [
                            const Tab(
                              text: "Home",
                            ),
                            const Tab(
                              text: "Non Coffee",
                            ),
                            const Tab(
                              text: "Pastry",
                            ),
                          ],
                        ),
                        const Align(
                            alignment: Alignment.topLeft, child: HomeFilter()),
                        SizedBox(
                          height: Product.products.length * 70 +
                              Product.products.length * 8 +
                              kBottomNavigationBarHeight,
                          child: TabBarView(
                            children: [
                              ListView.separated(
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: Product.products.length,
                                itemBuilder: (context, index) =>
                                    HomeProduct(index),
                                separatorBuilder: (context, int index) =>
                                    SizedBox(
                                  height: 8,
                                ),
                              ),
                              ListView.separated(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: Product.products.length,
                                itemBuilder: (context, index) =>
                                    HomeProduct(index),
                                separatorBuilder: (context, int index) =>
                                    SizedBox(
                                  height: 8,
                                ),
                              ),
                              ListView.separated(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: Product.products.length,
                                itemBuilder: (context, index) =>
                                    HomeProduct(index),
                                separatorBuilder: (context, int index) =>
                                    SizedBox(
                                  height: 8,
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    )),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: myBottomNavigationBar,
    );
  }
}
