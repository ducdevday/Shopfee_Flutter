import 'package:flutter/material.dart';
import 'package:shopfee/core/config/app_color.dart';
import 'package:shopfee/core/config/app_dimen.dart';
import 'package:shopfee/core/config/app_style.dart';
import 'package:shopfee/core/utils/navigation_util.dart';
import 'package:shopfee/features/store_detail/presentation/page/store_detail_page.dart';

class StorePage extends StatefulWidget {
  static const int indexPage = 2;
  const StorePage({Key? key}) : super(key: key);

  @override
  State<StorePage> createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("All Store"),
        actions: [const Icon(Icons.notifications_none_outlined)],
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Divider(height: 1),
        ),
      ),
      backgroundColor: const Color(0xffEFEBE9),
      body: Padding(
        padding: EdgeInsets.all(AppDimen.spacing),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    style: AppStyle.smallTextStyleDark,
                    onChanged: (value) => {},
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                      suffixIcon: Icon(Icons.search),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(color: Color(0xffCCCCCC)),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(color: Color(0xffCCCCCC)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(color: AppColor.primaryColor),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(color: Color(0xffCCCCCC)),
                      ),
                      hintText: "Find Any Store",
                    ),
                  ),
                ),
                SizedBox(width: 10),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  child: Row(
                    children: [
                      Icon(
                        Icons.map,
                      ),
                    ],
                  ),
                )
              ],
            ),
            Expanded(
              child: ListView.separated(
                  padding: EdgeInsets.only(top: AppDimen.spacing),
                  itemBuilder: (context, index) => InkWell(
                    onTap: (){
                      NavigationUtil.pushNamed(StoreDetailPage.route);
                    },
                    child: Container(
                          height: 100,
                          padding: EdgeInsets.all(AppDimen.spacing),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(
                                Radius.circular(AppDimen.smallRadius)),
                          ),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(AppDimen.smallRadius)),
                                child: Image.network(
                                  "https://maytreynhi.com/upload/news/the-coffee-house-co-nhuong-quyen-khong-3668.jpg",
                                  fit: BoxFit.cover,
                                  width: 90,
                                  height: 100,
                                ),
                              ),
                              SizedBox(
                                width: AppDimen.spacing,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Vo Van Ngan",
                                    style: AppStyle.mediumTextStyleDark,
                                  ),
                                  Spacer(),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.location_on_outlined,
                                        size: 16,
                                      ),
                                      Text(
                                        "No 1 Vo Van Ngan Q9 HCM",
                                        style: AppStyle.smallTextStyleDark,
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "3km away",
                                    style: AppStyle.normalTextStyleDark,
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                  ),
                  separatorBuilder: (context, index) => SizedBox(
                        height: AppDimen.spacing,
                      ),
                  itemCount: 2),
            )
          ],
        ),
      ),
    );
  }
}
