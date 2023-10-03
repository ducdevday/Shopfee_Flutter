import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shopfee/app/common/data/global_data.dart';
import 'package:shopfee/app/common/widgets/my_bottom_navigationbar.dart';
import 'package:shopfee/app/config/color.dart';
import 'package:shopfee/app/config/dimens.dart';
import 'package:shopfee/app/config/style.dart';
import 'package:shopfee/app/features/cart/bloc/cart_bloc.dart';
import 'package:shopfee/app/features/home/widgets/home_filter.dart';
import 'package:shopfee/app/features/home/widgets/home_float_action.dart';
import 'package:shopfee/app/features/home/widgets/home_product.dart';
import 'package:shopfee/app/features/home/widgets/home_slider.dart';
import 'package:shopfee/data/models/product.dart';

class HomeScreen extends StatelessWidget {
  final MyBottomNavigationBar myBottomNavigationBar;

  const HomeScreen(this.myBottomNavigationBar, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _determinePosition();
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
                              Product.products.length * 16 +
                              kBottomNavigationBarHeight +
                              70,
                          child: TabBarView(
                            children: [
                              ListView.separated(
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: Product.products.length,
                                itemBuilder: (context, index) =>
                                    HomeProduct(Product.products[index]),
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
                                    HomeProduct(Product.products[index]),
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
                                    HomeProduct(Product.products[index]),
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
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
      floatingActionButton: HomeFloatAction(),
      bottomNavigationBar: myBottomNavigationBar,
    );
  }
}

Future<Position> _determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location services are not enabled don't continue
    // accessing the position and request users of the
    // App to enable the location services.
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Permissions are denied, next time you could try
      // requesting permissions again (this is also where
      // Android's shouldShowRequestPermissionRationale
      // returned true. According to Android guidelines
      // your App should show an explanatory UI now.
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately.
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }

  // When we reach here, permissions are granted and we can
  // continue accessing the position of the device.
  return await Geolocator.getCurrentPosition();
}

