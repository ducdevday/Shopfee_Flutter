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

  ValueNotifier<bool> isValidNotifier = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    _bloc = ServiceLocator.sl<ChooseAddressBloc>()
      ..add(ChooseAddressLoadProvince());
    provinceTextController = TextEditingController();
    districtTextController = TextEditingController();
    wardTextController = TextEditingController();
    addressNoController = TextEditingController();
    addressNoController.addListener(() {
      checkValid();
    });
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

  void checkValid() {
    if (provinceTextController.text.isNotEmpty &&
        districtTextController.text.isNotEmpty &&
        wardTextController.text.isNotEmpty &&
        addressNoController.text.trim().isNotEmpty) {
      isValidNotifier.value = true;
    } else {
      isValidNotifier.value = false;
    }
  }

  String formattedAddress() {
    return "${addressNoController.text.trim()}, ${wardTextController.text}, ${districtTextController.text}, ${provinceTextController.text}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text("Choose Address"),
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
                }
              },
              builder: (context, state) {
                if (state is ChooseAddressLoadSuccess) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.all(AppDimen.screenPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DropdownMenu(
                          label: Text("Province"),
                          menuHeight: 200,
                          width: MediaQuery.of(context).size.width -
                              AppDimen.screenPadding * 2,
                          onSelected: (province) => {
                            _bloc.add(
                                ChooseAddressPickProvince(province: province))
                          },
                          dropdownMenuEntries: [
                            ...state.provinceList.mapIndexed((index, e) =>
                                DropdownMenuEntry(
                                    value: state.provinceList[index],
                                    label: state
                                            .provinceList[index].provinceName ??
                                        ""))
                          ],
                          controller: provinceTextController,
                          inputDecorationTheme: InputDecorationTheme(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 12),
                            focusedErrorBorder:
                                AppStyle.outlineInputBorderDefault,
                            errorBorder: AppStyle.outlineInputBorderDefault,
                            enabledBorder: AppStyle.outlineInputBorderDefault,
                            focusedBorder: AppStyle.outlineInputBorderPrimary,
                            disabledBorder: AppStyle.outlineInputBorderDefault,
                          ),
                        ),
                        const SizedBox(
                          height: AppDimen.smallPadding,
                        ),
                        DropdownMenu(
                          label: Text("District"),
                          menuHeight: 200,
                          width: MediaQuery.of(context).size.width -
                              AppDimen.screenPadding * 2,
                          onSelected: (district) => {
                            _bloc.add(
                                ChooseAddressPickDistrict(district: district))
                          },
                          dropdownMenuEntries: [
                            ...state.districtList.mapIndexed((index, e) =>
                                DropdownMenuEntry(
                                    value: state.districtList[index],
                                    label: state
                                            .districtList[index].districtName ??
                                        ""))
                          ],
                          controller: districtTextController,
                          inputDecorationTheme: InputDecorationTheme(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 12),
                            focusedErrorBorder:
                                AppStyle.outlineInputBorderDefault,
                            errorBorder: AppStyle.outlineInputBorderDefault,
                            enabledBorder: AppStyle.outlineInputBorderDefault,
                            focusedBorder: AppStyle.outlineInputBorderPrimary,
                            disabledBorder: AppStyle.outlineInputBorderDefault,
                          ),
                        ),
                        const SizedBox(
                          height: AppDimen.smallPadding,
                        ),
                        DropdownMenu(
                          label: Text("Ward"),
                          menuHeight: 200,
                          width: MediaQuery.of(context).size.width -
                              AppDimen.screenPadding * 2,
                          onSelected: (ward) =>
                              {_bloc.add(ChooseAddressPickWard(ward: ward))},
                          dropdownMenuEntries: [
                            ...state.wardList.mapIndexed((index, e) =>
                                DropdownMenuEntry(
                                    value: state.wardList[index],
                                    label:
                                        state.wardList[index].wardName ?? "")),
                          ],
                          controller: wardTextController,
                          inputDecorationTheme: InputDecorationTheme(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 12),
                            focusedErrorBorder:
                                AppStyle.outlineInputBorderDefault,
                            errorBorder: AppStyle.outlineInputBorderDefault,
                            enabledBorder: AppStyle.outlineInputBorderDefault,
                            focusedBorder: AppStyle.outlineInputBorderPrimary,
                            disabledBorder: AppStyle.outlineInputBorderDefault,
                          ),
                        ),
                        const SizedBox(
                          height: AppDimen.smallPadding,
                        ),
                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please fill this section';
                            }
                            return null;
                          },
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
                            disabledBorder: AppStyle.outlineInputBorderDefault,
                          ),
                        ),
                        const SizedBox(
                          height: AppDimen.smallPadding,
                        ),
                        ValueListenableBuilder(
                          valueListenable: isValidNotifier,
                          builder: (BuildContext context, bool isValid,
                              Widget? child) {
                            return SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: isValid == true
                                    ? () {
                                        NavigationUtil.pushNamed(
                                                GoogleMapPage.route,
                                                arguments: formattedAddress())
                                            .then((geoResult) {
                                          if (geoResult != null) {
                                            final GeoResultEntity
                                                geoResultEntity =
                                                geoResult as GeoResultEntity;
                                            NavigationUtil.pop(
                                                result: geoResultEntity);
                                          }
                                        });
                                      }
                                    : null,
                                style: AppStyle.elevatedButtonStylePrimary,
                                child: const Text("Mark Address In Map"),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  );
                }
                return SizedBox();
              },
            ),
          ),
        ));
  }
}
