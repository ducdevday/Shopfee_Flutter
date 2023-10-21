import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shopfee/app/common/widgets/my_bottom_navigationbar.dart';
import 'package:shopfee/app/common/widgets/my_error.dart';
import 'package:shopfee/app/common/widgets/my_loading.dart';
import 'package:shopfee/app/config/dimens.dart';
import 'package:shopfee/app/config/style.dart';
import 'package:shopfee/app/features/home/bloc/home_bloc.dart';
import 'package:shopfee/app/features/home/widgets/home_float_action.dart';
import 'package:shopfee/app/features/home/widgets/home_product.dart';
import 'package:shopfee/app/features/home/widgets/home_skeleton.dart';
import 'package:shopfee/app/features/home/widgets/home_slider.dart';
import 'package:shopfee/app/features/product_by_category_id/screen/product_by_category_id_screen.dart';
import 'package:shopfee/data/repositories/category/category_repository.dart';
import 'package:shopfee/data/repositories/product/product_repository.dart';

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
              toolbarHeight: 70,
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
        body: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is HomeLoading) {
              return HomeSkeleton();
            } else if (state is HomeLoaded) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: AppDimen.spacing,
                    ),
                    const HomeSlider(),
                    const SizedBox(
                      height: AppDimen.spacing,
                    ),
                    Column(
                      children: [
                        Container(
                          height: 80,
                          child: Scrollbar(
                            thickness: 1,
                            child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) => InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ProductByCategoryIdScreen(
                                                        categoryId: state
                                                            .categories[index]
                                                            .id!,
                                                        categoryName: state
                                                            .categories[index]
                                                            .name!)));
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: AppDimen.spacing),
                                        child: Column(
                                          children: [
                                            Image(
                                              image: NetworkImage(state
                                                  .categories[index]
                                                  .image!
                                                  .url!),
                                              width: 60,
                                              height: 60,
                                            ),
                                            Text(
                                              state.categories[index].name!,
                                              style: AppStyle
                                                  .mediumTextStyleDark,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                separatorBuilder: (context, index) =>
                                    const SizedBox(),
                                itemCount: state.categories.length),
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: AppDimen.screenPadding),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Outstanding Products",
                              style: AppStyle.mediumTitleStyleDark,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        ListView.separated(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: state.products.length,
                          itemBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: AppDimen.screenPadding),
                            child: HomeProduct(state.products[index]),
                          ),
                          separatorBuilder: (context, int index) =>
                              const Divider(
                            height: 8,
                            thickness: 0.75,
                          ),
                        ),
                        const SizedBox(
                          height: 68,
                        ),
                      ],
                    )
                  ],
                ),
              );
            } else {
              return MyError();
            }
          },
        ),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
      floatingActionButton: const HomeFloatAction(),
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
