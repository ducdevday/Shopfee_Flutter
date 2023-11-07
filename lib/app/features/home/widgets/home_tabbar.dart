import 'package:flutter/material.dart';

// Cái này để kỳ sau sài
class HomeTabBar extends StatelessWidget {
  const HomeTabBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox();
      // Padding(
      //   padding: const EdgeInsets.symmetric(
      //       horizontal: AppDimen.screenPadding),
      //   child: DefaultTabController(
      //       length: state.categories.length,
      //       child: Column(
      //         children: [
      //           HomeTabBar(),
      //           // const Align(
      //           //     alignment: Alignment.topLeft, child: HomeFilter()),
      //           SizedBox(
      //             height: ProductTemp.products.length * 70 +
      //                 ProductTemp.products.length * 16 +
      //                 kBottomNavigationBarHeight +
      //                 70,
      //             child: TabBarView(
      //               c hildren: state.categories
      //                   .map((c) => ListView.separated(
      //                         padding: EdgeInsets.zero,
      //                         shrinkWrap: true,
      //                         physics:
      //                             NeverScrollableScrollPhysics(),
      //                         itemCount: state
      //                             .getProductByCategoryChosenId(
      //                                 c.id!)
      //                             .length,
      //                         itemBuilder: (context, index) =>
      //                             HomeProduct(state
      //                                 .getProductByCategoryChosenId(
      //                                     c.id!)[index]),
      //                         separatorBuilder:
      //                             (context, int index) =>
      //                                 Divider(
      //                           height: 8,
      //                           thickness: 0.75,
      //                         ),
      //                       ))
      //                   .toList(),
      //               // children: [
      //               //   ListView.separated(
      //               //     padding: EdgeInsets.zero,
      //               //     shrinkWrap: true,
      //               //     physics: NeverScrollableScrollPhysics(),
      //               //     itemCount: ProductTemp.products.length,
      //               //     itemBuilder: (context, index) =>
      //               //         HomeProductTemp(
      //               //             ProductTemp.products[index]),
      //               //     separatorBuilder:
      //               //         (context, int index) => Divider(
      //               //       height: 8,
      //               //           thickness: 0.75,
      //               //     ),
      //               //   ),
      //               //   ListView.separated(
      //               //     shrinkWrap: true,
      //               //     physics: NeverScrollableScrollPhysics(),
      //               //     itemCount: ProductTemp.products.length,
      //               //     itemBuilder: (context, index) =>
      //               //         HomeProductTemp(
      //               //             ProductTemp.products[index]),
      //               //     separatorBuilder:
      //               //         (context, int index) => SizedBox(
      //               //       height: 8,
      //               //     ),
      //               //   ),
      //               //   ListView.separated(
      //               //     shrinkWrap: true,
      //               //     physics: NeverScrollableScrollPhysics(),
      //               //     itemCount: ProductTemp.products.length,
      //               //     itemBuilder: (context, index) =>
      //               //         HomeProductTemp(
      //               //             ProductTemp.products[index]),
      //               //     separatorBuilder:
      //               //         (context, int index) => SizedBox(
      //               //       height: 8,
      //               //     ),
      //               //   ),
      //               //   ListView.separated(
      //               //     shrinkWrap: true,
      //               //     physics: NeverScrollableScrollPhysics(),
      //               //     itemCount: ProductTemp.products.length,
      //               //     itemBuilder: (context, index) =>
      //               //         HomeProductTemp(
      //               //             ProductTemp.products[index]),
      //               //     separatorBuilder:
      //               //         (context, int index) => SizedBox(
      //               //       height: 8,
      //               //     ),
      //               //   )
      //               // ],
      //             ),
      //           ),
      //         ],
      //       )),
      // )
  }
}
