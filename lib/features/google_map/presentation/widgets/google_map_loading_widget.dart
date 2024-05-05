part of google_map;

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
