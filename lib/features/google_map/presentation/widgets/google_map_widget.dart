part of google_map;

class GoogleMapWidget extends StatefulWidget {
  const GoogleMapWidget({super.key});

  @override
  State<GoogleMapWidget> createState() => _GoogleMapWidgetState();
}

class _GoogleMapWidgetState extends State<GoogleMapWidget> {
  GoogleMapController? mapController;

  @override
  void dispose() {
    mapController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GoogleMapBloc, GoogleMapState>(
      builder: (context, state) {
        if (state is GoogleMapPhase2State) {
          final LatLng _latLng = LatLng(
              state.markLatPosition ?? state.originalLatPosition,
              state.markLngPosition ?? state.originalLngPosition);
          final Marker _marker = Marker(
              markerId: MarkerId("markerUser"),
              // infoWindow: InfoWindow(title: "Đức Nguyễn"),
              icon: BitmapDescriptor.defaultMarker,
              position: _latLng);
          mapController?.animateCamera(CameraUpdate.newLatLng(_latLng));
          return Expanded(
            child: Stack(
              children: [
                GoogleMap(
                  onMapCreated: (controller) {
                    //method called when map is created
                    setState(() {
                      mapController = controller;
                    });
                  },
                  myLocationEnabled: true,
                  markers: {_marker},
                  initialCameraPosition:
                      CameraPosition(target: _latLng, zoom: 17),
                  onTap: (LatLng latLng) => {
                    context.read<GoogleMapBloc>().add(GoogleMapMarkPosition(
                        latitude: latLng.latitude, longitude: latLng.longitude))
                  },
                ),
                // LocationHeader(),
                Positioned(
                    bottom: 20,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.symmetric(
                          horizontal: AppDimen.screenPadding),
                      child: ElevatedButton(
                        style: AppStyle.elevatedButtonStylePrimary,
                        onPressed: () {
                          context
                              .read<GoogleMapBloc>()
                              .add(GoogleMapConfirmDone());
                        },
                        child: Text(R.confirmAddress.tr()),
                      ),
                    ))
              ],
            ),
          );
        }
        return SizedBox();
      },
    );
  }
}
