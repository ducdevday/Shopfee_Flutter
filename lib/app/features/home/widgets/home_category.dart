import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopfee/app/config/color.dart';
import 'package:shopfee/app/config/style.dart';
import 'package:shopfee/app/features/home/bloc/home_bloc.dart';

class HomeCategory extends StatelessWidget {
  const HomeCategory({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is HomeLoaded) {
          return TabBar(
            onTap: (index) => {
              context.read<HomeBloc>().add(ChooseCategoryHome(id: state.categories[index].id!))
            },
            isScrollable: true,
            unselectedLabelColor: AppColor.disableColor,
            indicatorColor: AppColor.primaryColor,
            labelColor: AppColor.primaryColor,
            tabs: state.categories
                .map((category) => Tab(
                      height: 80,
                      child: Column(
                        children: [
                          Image(
                            image: NetworkImage(category.image!.url!),
                            width: 60,
                            height: 60,
                          ),
                          Text(
                            category.name!,
                            style: AppStyle.mediumTextStyleDark,
                          )
                        ],
                      ),
                    ))
                .toList(),
          );
        } else {
          return SizedBox();
        }
      },
    );
  }
}
