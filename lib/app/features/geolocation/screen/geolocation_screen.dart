import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shopfee/app/features/geolocation/bloc/geolocation_bloc.dart';

class GeolocationScreen extends StatefulWidget {
  const GeolocationScreen({Key? key}) : super(key: key);

  @override
  State<GeolocationScreen> createState() => _GeolocationScreenState();
}

class _GeolocationScreenState extends State<GeolocationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Choose Your Address"),
        centerTitle: true,
      ),
      body: BlocBuilder<GeolocationBloc, GeolocationState>(
        builder: (context, state) {
          if (state is GeolocationLoaded) {
            final loadedState = state as GeolocationLoaded;
            final Marker _marker = Marker(
                markerId: MarkerId("markerUser"),
                infoWindow: InfoWindow(title: "Đức Nguyễn"),
                icon: BitmapDescriptor.defaultMarker,
                position: LatLng(loadedState.position.latitude,
                    loadedState.position.longitude));
            return GoogleMap(
                myLocationEnabled: true,
                markers: {_marker},
                myLocationButtonEnabled: true,
                initialCameraPosition: CameraPosition(
                    target: LatLng(loadedState.position.latitude,
                        loadedState.position.longitude),
                    zoom: 15));
          } else {
            return SizedBox();
          }
        },
      ),
    );
  }
}
