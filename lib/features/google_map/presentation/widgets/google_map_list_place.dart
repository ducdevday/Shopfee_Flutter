part of google_map;
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
