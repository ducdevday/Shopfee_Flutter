import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopfee/app/config/dimens.dart';
import 'package:shopfee/app/config/style.dart';
import 'package:shopfee/app/features/geolocation/bloc/geolocation_bloc.dart';
import 'package:shopfee/app/features/geolocation/bloc/geolocation_bloc.dart';

class ChooseButton extends StatelessWidget {
  const ChooseButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GeolocationBloc, GeolocationState>(
      builder: (context, state) {
        if(state is GeolocationLoaded){
          return Positioned(
              bottom: 20,
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.symmetric(
                    horizontal: AppDimen.screenPadding),
                child: ElevatedButton(
                  child: const Text("Finish"),
                  style: AppStyle.elevatedButtonStylePrimary,
                  onPressed: state.placeSearchChoose != null ? () {
                    Navigator.pop(context, state.placeSearchChoose);
                  } : null,
                ),
              ));
        }
        else{
          return const SizedBox();
        }
      },
    );
  }
}
