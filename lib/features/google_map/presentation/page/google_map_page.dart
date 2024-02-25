import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shopfee/core/config/app_dimen.dart';
import 'package:shopfee/core/config/app_style.dart';
import 'package:shopfee/core/di/service_locator.dart';
import 'package:shopfee/core/utils/navigation_util.dart';
import 'package:shopfee/features/google_map/domain/entities/geo_result_entity.dart';
import 'package:shopfee/features/google_map/presentation/bloc/google_map_bloc.dart';

class GoogleMapPage extends StatefulWidget {
  static const String route = "/google_map";
  final String addressString;

  const GoogleMapPage({Key? key, required this.addressString})
      : super(key: key);

  @override
  State<GoogleMapPage> createState() => _GoogleMapPageState();
}

class _GoogleMapPageState extends State<GoogleMapPage> {
  late final GoogleMapBloc _bloc;
  GoogleMapController? mapController;

  @override
  void initState() {
    super.initState();
    _bloc = ServiceLocator.sl<GoogleMapBloc>()
      ..add(GoogleMapLoadInitPosition(addressString: widget.addressString));
  }

  @override
  void dispose() {
    _bloc.close();
    mapController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mark your address"),
        centerTitle: true,
      ),
      body: BlocProvider(
        create: (context) => _bloc,
        child: BlocConsumer<GoogleMapBloc, GoogleMapState>(
          listener: (context, state) {
            switch (state) {}
          },
          builder: (context, state) {
            if (state is GoogleMapLoadSuccess) {
              final Marker _marker = Marker(
                  markerId: MarkerId("markerUser"),
                  // infoWindow: InfoWindow(title: "Đức Nguyễn"),
                  icon: BitmapDescriptor.defaultMarker,
                  position: LatLng(
                      state.currentLatPosition, state.currentLngPosition));
              mapController?.animateCamera(CameraUpdate.newLatLng(
                  LatLng(state.currentLatPosition, state.currentLngPosition)));
              return Stack(
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
                    initialCameraPosition: CameraPosition(
                        target: LatLng(
                            state.currentLatPosition, state.currentLngPosition),
                        zoom: 17),
                    onTap: (LatLng latLng) => {
                      _bloc.add(GoogleMapMarkPosition(
                          latitude: latLng.latitude,
                          longitude: latLng.longitude))
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
                            NavigationUtil.pop(
                                result: GeoResultEntity(
                                    formattedAddress: state.formattedString ??
                                        widget.addressString,
                                    lat: state.currentLatPosition,
                                    lng: state.currentLngPosition));
                          },
                          child: const Text("Confirm Address"),
                        ),
                      ))
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
