import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopfee/app/config/dimens.dart';
import 'package:shopfee/app/features/geolocation/bloc/geolocation_bloc.dart';

class LocationSearchBox extends StatefulWidget {
  final String value;

  const LocationSearchBox({Key? key, this.value = ""}) : super(key: key);

  @override
  State<LocationSearchBox> createState() => _LocationSearchBoxState();
}

class _LocationSearchBoxState extends State<LocationSearchBox> {
  bool isLoading = false;

  void startLoading() {
    setState(() {
      isLoading = true;
      Future.delayed(const Duration(milliseconds: 500))
          .then((value) => setState((){
        isLoading = false;

      }));
    });
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller =
        TextEditingController(text: widget.value);
    return Padding(
      padding: const EdgeInsets.symmetric(
          vertical: 8.0, horizontal: AppDimen.screenPadding),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: "Enter Your Location",
          suffixIcon: GestureDetector(
              onTap: () {
                startLoading();
                context
                    .read<GeolocationBloc>()
                    .add(SearchPlace(queryString: controller.text));
              },
              // child: !isLoading?  const Icon(Icons.search) : CupertinoActivityIndicator()),
              child: !isLoading?  const Icon(Icons.search) : CupertinoActivityIndicator()),
          contentPadding: const EdgeInsets.only(left: 20, bottom: 5, right: 5),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.white)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.white)),
        ),
        // onChanged: (value) => {
        // },
      ),
    );
  }
}
