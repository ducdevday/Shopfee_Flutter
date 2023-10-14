import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopfee/app/config/dimens.dart';
import 'package:shopfee/app/config/style.dart';
import 'package:shopfee/app/features/geolocation/bloc/geolocation_bloc.dart';
import 'package:shopfee/app/features/geolocation/widgets/location_search_box.dart';

class LocationHeader extends StatelessWidget {
  const LocationHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 10,
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: BlocBuilder<GeolocationBloc, GeolocationState>(
          builder: (context, state) {
            if (state is GeolocationLoaded) {
              return Column(
                children: [
                  LocationSearchBox(
                      value: state.placeSearchChoose != null && state.placeSearchList.isEmpty
                          ? "${state.placeSearchChoose!.name} ${state.placeSearchChoose!.formattedAddress}"
                          : ""),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 4, horizontal: AppDimen.screenPadding),
                    height: 200,
                    color: state.placeSearchList.isNotEmpty
                        ? Colors.white
                        : Colors.transparent,
                    child: ListView.separated(
                      itemCount: state.placeSearchList.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(
                            "${state.placeSearchList[index].name} ${state.placeSearchList[index].formattedAddress}",
                            style: AppStyle.normalTextStyleDark,
                          ),
                          onTap: () {
                            context.read<GeolocationBloc>().add(ChoosePlace(
                                placeSearchChoose:
                                    state.placeSearchList[index]));
                          },
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const Divider(
                          height: 1,
                        );
                      },
                    ),
                  )
                ],
              );
            } else {
              return SizedBox();
            }
          },
        ),
      ),
    );
  }
}
