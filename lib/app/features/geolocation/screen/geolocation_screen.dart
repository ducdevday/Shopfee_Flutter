import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shopfee/app/common/widgets/my_error.dart';

import 'package:shopfee/app/features/geolocation/bloc/geolocation_bloc.dart';
import 'package:shopfee/app/features/geolocation/widgets/choose_button.dart';
import 'package:shopfee/app/features/geolocation/widgets/location_header.dart';
import 'package:shopfee/data/repositories/geolocation/geolocation_repository.dart';
import 'package:shopfee/data/repositories/place/place_repository.dart';

class GeolocationScreen extends StatefulWidget {
  const GeolocationScreen({Key? key}) : super(key: key);

  @override
  State<GeolocationScreen> createState() => _GeolocationScreenState();
}

class _GeolocationScreenState extends State<GeolocationScreen> {
  GoogleMapController? mapController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Choose Your Address"),
        centerTitle: true,
      ),
      body: BlocProvider(
        create: (context) => GeolocationBloc(
          geolocationRepository: context.read<GeolocationRepository>(),
          placeRepository: context.read<PlaceRepository>(),
        )..add(LoadGeolocation()),
        child: BlocBuilder<GeolocationBloc, GeolocationState>(
          builder: (context, state) {
            if (state is GeolocationLoaded) {
              final Marker _marker = Marker(
                  markerId: MarkerId("markerUser"),
                  // infoWindow: InfoWindow(title: "Đức Nguyễn"),
                  icon: BitmapDescriptor.defaultMarker,
                  position: LatLng(state.latitude, state.longitude));
              mapController?.animateCamera(CameraUpdate.newLatLng(
                  LatLng(state.latitude, state.longitude)));
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
                        target: LatLng(state.latitude, state.longitude),
                        zoom: 15),
                  ),
                  LocationHeader(),
                  ChooseButton()
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
