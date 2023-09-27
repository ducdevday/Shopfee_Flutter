import 'package:flutter/material.dart';
import 'package:shopfee/app/config/dimens.dart';
import 'package:shopfee/app/config/style.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Row(
            children: [
              IconButton(
                padding: EdgeInsets.zero,
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                constraints: BoxConstraints(),
                icon: Icon(Icons.arrow_back_outlined),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              SizedBox(width: 10),
              Expanded(
                child: TextField(
                  autofocus: true,
                  style: AppStyle.smallTextStyleDark,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(8),
                    suffixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16)),
                    hintText: "What would you like to drink today?",
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
          padding: const EdgeInsets.all(AppDimen.screenPadding),
          child: Container()),
    );
  }
}
