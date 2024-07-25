part of choose_address;

class ChooseAddressPage extends StatefulWidget {
  static const String route = "/choose_address";

  const ChooseAddressPage({Key? key}) : super(key: key);

  @override
  State<ChooseAddressPage> createState() => _ChooseAddressPageState();
}

class _ChooseAddressPageState extends State<ChooseAddressPage> {
  late final ChooseAddressBloc _bloc;
  late final TextEditingController provinceTextController;
  late final TextEditingController districtTextController;
  late final TextEditingController wardTextController;
  late final TextEditingController addressNoController;

  @override
  void initState() {
    super.initState();
    _bloc = ServiceLocator.sl<ChooseAddressBloc>()
      ..add(ChooseAddressLoadProvince());
    provinceTextController = TextEditingController();
    districtTextController = TextEditingController();
    wardTextController = TextEditingController();
    addressNoController = TextEditingController();
  }

  @override
  void dispose() {
    _bloc.close();
    provinceTextController.dispose();
    districtTextController.dispose();
    wardTextController.dispose();
    addressNoController.dispose();
    super.dispose();
  }

  bool checkValid() {
    if (provinceTextController.text.isNotEmpty &&
        districtTextController.text.isNotEmpty &&
        wardTextController.text.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  String formattedAddress() {
    // return "${addressNoController.text.trim()}, ${wardTextController.text}, ${districtTextController.text}, ${provinceTextController.text}";
    return ", ${wardTextController.text}, ${districtTextController.text}, ${provinceTextController.text}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.scaffoldColorBackground,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(R.chooseAddress.tr()),
          centerTitle: true,
          bottom: const PreferredSize(
            preferredSize: Size.fromHeight(1),
            child: Divider(height: 1),
          ),
        ),
        body: SingleChildScrollView(
          child: BlocProvider(
            create: (context) => _bloc,
            child: BlocConsumer<ChooseAddressBloc, ChooseAddressState>(
              listener: (context, state) {
                checkValid();
                if (state is ChooseAddressLoadSuccess) {
                  if (state.chosenDistrict == null) {
                    districtTextController.text = "";
                  }
                  if (state.chosenWard == null) {
                    wardTextController.text = "";
                  }
                } else if (state is ChooseAddressFinished) {
                  NavigationUtil.pop(result: state.geoResultEntity);
                }
              },
              builder: (context, state) {
                if (state is ChooseAddressLoadSuccess) {
                  return Column(
                    children: [
                      const SizedBox(
                        height: AppDimen.spacing,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.all(AppDimen.screenPadding),
                        color: Colors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            DropdownMenu(
                              label: Text(R.province.tr()),
                              menuHeight: 200,
                              width: MediaQuery.of(context).size.width -
                                  AppDimen.screenPadding * 2,
                              onSelected: (province) => {
                                _bloc.add(ChooseAddressPickProvince(
                                    province: province))
                              },
                              dropdownMenuEntries: [
                                ...state.provinceList.mapIndexed((index, e) =>
                                    DropdownMenuEntry(
                                        value: state.provinceList[index],
                                        label: state.provinceList[index]
                                                .provinceName ??
                                            ""))
                              ],
                              controller: provinceTextController,
                              inputDecorationTheme: InputDecorationTheme(
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 12),
                                focusedErrorBorder:
                                    AppStyle.outlineInputBorderDefault,
                                errorBorder: AppStyle.outlineInputBorderDefault,
                                enabledBorder:
                                    AppStyle.outlineInputBorderDefault,
                                focusedBorder:
                                    AppStyle.outlineInputBorderPrimary,
                                disabledBorder:
                                    AppStyle.outlineInputBorderDefault,
                              ),
                            ),
                            const SizedBox(
                              height: AppDimen.smallPadding,
                            ),
                            DropdownMenu(
                              label: Text(R.district.tr()),
                              menuHeight: 200,
                              width: MediaQuery.of(context).size.width -
                                  AppDimen.screenPadding * 2,
                              onSelected: (district) => {
                                _bloc.add(ChooseAddressPickDistrict(
                                    district: district))
                              },
                              dropdownMenuEntries: [
                                ...state.districtList.mapIndexed((index, e) =>
                                    DropdownMenuEntry(
                                        value: state.districtList[index],
                                        label: state.districtList[index]
                                                .districtName ??
                                            ""))
                              ],
                              controller: districtTextController,
                              inputDecorationTheme: InputDecorationTheme(
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 12),
                                focusedErrorBorder:
                                    AppStyle.outlineInputBorderDefault,
                                errorBorder: AppStyle.outlineInputBorderDefault,
                                enabledBorder:
                                    AppStyle.outlineInputBorderDefault,
                                focusedBorder:
                                    AppStyle.outlineInputBorderPrimary,
                                disabledBorder:
                                    AppStyle.outlineInputBorderDefault,
                              ),
                            ),
                            const SizedBox(
                              height: AppDimen.smallPadding,
                            ),
                            DropdownMenu(
                              label: Text(R.ward.tr()),
                              menuHeight: 200,
                              width: MediaQuery.of(context).size.width -
                                  AppDimen.screenPadding * 2,
                              onSelected: (ward) => {
                                _bloc.add(ChooseAddressPickWard(ward: ward))
                              },
                              dropdownMenuEntries: [
                                ...state.wardList.mapIndexed((index, e) =>
                                    DropdownMenuEntry(
                                        value: state.wardList[index],
                                        label: state.wardList[index].wardName ??
                                            "")),
                              ],
                              controller: wardTextController,
                              inputDecorationTheme: InputDecorationTheme(
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 12),
                                focusedErrorBorder:
                                    AppStyle.outlineInputBorderDefault,
                                errorBorder: AppStyle.outlineInputBorderDefault,
                                enabledBorder:
                                    AppStyle.outlineInputBorderDefault,
                                focusedBorder:
                                    AppStyle.outlineInputBorderPrimary,
                                disabledBorder:
                                    AppStyle.outlineInputBorderDefault,
                              ),
                            ),
                            const SizedBox(
                              height: AppDimen.smallPadding,
                            ),
                            GestureDetector(
                              onTap: () {
                                if (checkValid()) {
                                  NavigationUtil.pushNamed(GoogleMapPage.route,
                                          arguments: formattedAddress())
                                      .then((geoResult) {
                                    if (geoResult != null &&
                                        geoResult is GeoResultEntity) {
                                      final GeoResultEntity geoResultEntity =
                                          GeoResultEntity(
                                              formattedAddress:
                                                  "${geoResult.formattedAddress}${formattedAddress()}",
                                              lat: geoResult.lat,
                                              lng: geoResult.lng);
                                      NavigationUtil.pop(
                                          result: geoResultEntity);
                                    }
                                  });
                                } else {
                                  EasyLoading.showInfo(
                                      R.pleaseChooseFullAddress.tr());
                                }
                              },
                              child: Hero(
                                tag: "addressNo",
                                child: TextFormField(
                                  enabled: false,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return R.pleaseFillThisSection.tr();
                                    }
                                    return null;
                                  },
                                  controller: addressNoController,
                                  decoration: InputDecoration(
                                    labelText: R.addressNo.tr(),
                                    labelStyle: TextStyle(color: Colors.black),
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 15, horizontal: 12),
                                    focusedErrorBorder:
                                        AppStyle.outlineInputBorderDefault,
                                    errorBorder:
                                        AppStyle.outlineInputBorderDefault,
                                    enabledBorder:
                                        AppStyle.outlineInputBorderDefault,
                                    focusedBorder:
                                        AppStyle.outlineInputBorderPrimary,
                                    disabledBorder:
                                        AppStyle.outlineInputBorderDefault,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: AppDimen.spacing,
                      ),
                      Container(
                          color: Colors.white,
                          margin: EdgeInsets.symmetric(
                              horizontal: AppDimen.screenPadding),
                          child: GestureDetector(
                            onTap: () {
                              _bloc.add(ChooseAddressUseCurrentPosition());
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: AppDimen.spacing,
                                  horizontal: AppDimen.screenPadding),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.location_searching_outlined,
                                    color: AppColor.primaryColor,
                                  ),
                                  SizedBox(
                                    width: AppDimen.spacing,
                                  ),
                                  Text(
                                    R.useMyCurrentPosition.tr(),
                                    style: AppStyle.normalTextStyleDark,
                                  )
                                ],
                              ),
                            ),
                          )),
                    ],
                  );
                }
                return SizedBox();
              },
            ),
          ),
        ));
  }
}
