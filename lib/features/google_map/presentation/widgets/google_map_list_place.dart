import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopfee/core/config/app_color.dart';
import 'package:shopfee/core/config/app_dimen.dart';
import 'package:shopfee/core/config/app_style.dart';
import 'package:shopfee/features/google_map/presentation/bloc/google_map_bloc.dart';

class GoogleMapListPlace extends StatelessWidget {
  const GoogleMapListPlace({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GoogleMapBloc, GoogleMapState>(
      builder: (context, state) {
        if (state is GoogleMapPhase1State) {
          return Expanded(
            child: ListView.separated(
                padding: EdgeInsets.all(AppDimen.spacing),
                itemBuilder: (context, index) => InkWell(
                      onTap: () {
                        context.read<GoogleMapBloc>().add(GoogleMapSelectPlace(
                            autoCompleteResultEntity:
                                state.autoCompletePlaceList[index]));
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            color: AppColor.nonactiveColor,
                          ),
                          Expanded(
                            child: Text(
                              state.autoCompletePlaceList[index].description,
                              style: AppStyle.mediumTextStyleDark,
                            ),
                          )
                        ],
                      ),
                    ),
                separatorBuilder: (context, index) => Divider(),
                itemCount: state.autoCompletePlaceList.length),
          );
        }
        return SizedBox();
      },
    );
  }
}
