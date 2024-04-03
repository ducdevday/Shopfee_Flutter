part of store;

class StoreMapView extends StatefulWidget {
  final List<StoreInformationEntity> storeList;
  final Position currentPosition;
  final StoreViewType currentViewType;
  final String fromRoute;

  const StoreMapView(
      {Key? key,
      required this.storeList,
      required this.currentPosition,
      required this.currentViewType,
      required this.fromRoute})
      : super(key: key);

  @override
  State<StoreMapView> createState() => _StoreMapViewState();
}

class _StoreMapViewState extends State<StoreMapView> {
  GoogleMapController? mapController;
  final Set<Marker> markerList = {};
  late LatLng currentCamera;

  @override
  void initState() {
    super.initState();
    currentCamera = LatLng(
        widget.currentPosition.latitude, widget.currentPosition.longitude);
  }

  @override
  void dispose() {
    mapController?.dispose();
    super.dispose();
  }

  void createMarkers() {
    // markerList.add(Marker(
    //     markerId: const MarkerId("markerUser"),
    //     icon: BitmapDescriptor.defaultMarker,
    //     position: LatLng(widget.currentPosition.latitude,
    //         widget.currentPosition.longitude)));

    markerList.addAll(widget.storeList
        .map((store) => Marker(
              markerId: MarkerId(store.id!.toString()),
              icon: GlobalData.ins.customIcon,
              infoWindow: InfoWindow(
                  title: "${store.name}",
                  onTap: () {
                    if (widget.fromRoute != CartPage.route) {
                      NavigationUtil.pushNamed(StoreDetailPage.route,
                          arguments: store.id!);
                    } else {
                      NavigationUtil.pop(result: store.id!);
                    }
                  }),
              position: LatLng(store.latitude!, store.longitude!),
            ))
        .toList());
  }

  @override
  Widget build(BuildContext context) {
    // mapController?.animateCamera(CameraUpdate.newLatLng(LatLng(
    //     currentCamera.latitude, currentCamera.longitude)));
    return Visibility(
      visible: widget.currentViewType == StoreViewType.Map_View,
      maintainSize: true,
      maintainAnimation: true,
      maintainState: true,
      child: Stack(
        children: [
          GoogleMap(
            onMapCreated: (controller) {
              //method called when map is created
              setState(() {
                mapController = controller;
                createMarkers();
              });
            },
            markers: markerList,
            myLocationEnabled: true,
            initialCameraPosition:
                CameraPosition(target: currentCamera, zoom: 17),
            onCameraMove: (cameraPosition) {
              currentCamera = cameraPosition.target;
            },
          ),
          // LocationHeader(),
        ],
      ),
    );
  }
}
