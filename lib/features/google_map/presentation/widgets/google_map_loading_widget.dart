import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopfee/features/google_map/presentation/bloc/google_map_bloc.dart';

class GoogleMapLoadingWidget extends StatelessWidget {
  const GoogleMapLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GoogleMapBloc, GoogleMapState>(
      builder: (context, state) {
        if (state is GoogleMapLoadInProcess) {
          return Expanded(
            child: Center(
              child: CupertinoActivityIndicator(),
            ),
          );
        }
        return SizedBox();
      },
    );
  }
}
