part of google_map;

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
  late final TextEditingController addressNoController;
  late final DebounceController debounceController;
  ValueNotifier<bool> enableAddressNo = ValueNotifier(true);

  @override
  void initState() {
    super.initState();
    _bloc = ServiceLocator.sl<GoogleMapBloc>();
    addressNoController = TextEditingController();
    debounceController = DebounceController();
  }

  @override
  void dispose() {
    _bloc.close();
    mapController?.dispose();
    addressNoController.dispose();
    debounceController.dispose();
    enableAddressNo.dispose();
    super.dispose();
  }

  void handleSearchPlace(String value) {
    debounceController.run(() => _bloc.add(
        GoogleMapEnterAddressNoText(input: "${value}${widget.addressString}")));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.scaffoldColorBackground,
      appBar: AppBar(
        title: Text("Mark your address"),
        centerTitle: true,
        backgroundColor: Colors.white,
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Divider(height: 1),
        ),
      ),
      body: BlocProvider(
        create: (context) => _bloc,
        child: Builder(builder: (context) {
          return BlocListener<GoogleMapBloc, GoogleMapState>(
            listener: (context, state) {
              if (state is GoogleMapPhase2State) {
                addressNoController.text = state.originalString;
                enableAddressNo.value = false;
              } else if (state is GoogleMapFinished) {
                NavigationUtil.pop(result: state.geoResultEntity);
              }
            },
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  color: Colors.white,
                  padding: const EdgeInsets.all(AppDimen.spacing),
                  child: ValueListenableBuilder<bool>(
                    valueListenable: enableAddressNo,
                    builder:
                        (BuildContext context, bool isEnable, Widget? child) {
                      return GestureDetector(
                        onTap: !isEnable
                            ? () {
                                _bloc.add(GoogleMapEnterAddressNoText(
                                    input:
                                        "${addressNoController.text}${widget.addressString}"));
                                enableAddressNo.value = true;
                              }
                            : null,
                        child: Hero(
                          tag: "addressNo",
                          child: TextFormField(
                            enabled: isEnable,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please fill this section';
                              }
                              return null;
                            },
                            onChanged: (value) => handleSearchPlace(value),
                            controller: addressNoController,
                            decoration: InputDecoration(
                              labelText: "Address No",
                              labelStyle: TextStyle(color: Colors.black),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 12),
                              focusedErrorBorder:
                                  AppStyle.outlineInputBorderDefault,
                              errorBorder: AppStyle.outlineInputBorderDefault,
                              enabledBorder: AppStyle.outlineInputBorderDefault,
                              focusedBorder: AppStyle.outlineInputBorderPrimary,
                              disabledBorder:
                                  AppStyle.outlineInputBorderDefault,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                GoogleMapLoadingWidget(),
                GoogleMapListPlace(),
                GoogleMapWidget()
              ],
            ),
          );
        }),
      ),
    );
  }
}
