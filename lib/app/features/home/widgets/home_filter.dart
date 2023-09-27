import 'package:flutter/material.dart';
import 'package:shopfee/app/config/color.dart';

class Filter {
  final IconData icon;
  final String title;

  Filter(this.icon, this.title);
}

class HomeFilter extends StatefulWidget {
  const HomeFilter({Key? key}) : super(key: key);

  @override
  State<HomeFilter> createState() => _HomeFilterState();
}

List<Filter> filters = [
  Filter(Icons.filter_alt_outlined, "Filter"),
  Filter(Icons.star_border_outlined, "Rating 4.5+"),
  Filter(Icons.attach_money_outlined, "Price"),
  Filter(Icons.percent_outlined, "Promotion"),
];

class _HomeFilterState extends State<HomeFilter> {
  List<Filter> myFilters = [];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return FilterChip(
              showCheckmark: false,
              selectedColor: AppColor.primaryColor,
              labelStyle: TextStyle(
                color: myFilters.contains(filters[index])
                    ? Colors.white
                    : AppColor.headingColor,
              ),
              label: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    filters[index].icon,
                    color: myFilters.contains(filters[index])
                        ? Colors.white
                        : AppColor.headingColor,
                  ),
                  Text(filters[index].title)
                ],
              ),
              selected: myFilters.contains(filters[index]),
              onSelected: (bool selected) {
                setState(() {
                  if (selected) {
                    myFilters.add(filters[index]);
                  } else {
                    myFilters.remove(filters[index]);
                  }
                });
              }
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(width: 8);
        },
        itemCount: filters.length,

      ),
    );
    // return Wrap(
    //     spacing: 5.0,
    //     children: filters
    //         .map((e) => FilterChip(
    //             showCheckmark: false,
    //             selectedColor: AppColor.primaryColor,
    //             labelStyle: TextStyle(
    //               color: myFilters.contains(e)
    //                   ? Colors.white
    //                   : AppColor.headingColor,
    //             ),
    //             label: Row(
    //               mainAxisSize: MainAxisSize.min,
    //               children: [
    //                 Icon(
    //                   e.icon,
    //                   color: myFilters.contains(e)
    //                       ? Colors.white
    //                       : AppColor.headingColor,
    //                 ),
    //                 Text(e.title)
    //               ],
    //             ),
    //             selected: myFilters.contains(e),
    //             onSelected: (bool selected) {
    //               setState(() {
    //                 if (selected) {
    //                   myFilters.add(e);
    //                 } else {
    //                   myFilters.remove(e);
    //                 }
    //               });
    //             }))
    //         .toList());
  }
}
