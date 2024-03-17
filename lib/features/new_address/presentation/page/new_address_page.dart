part of new_address;

class NewAddressPage extends StatefulWidget {
  static const String route = "/new_address";
  final String? addressId;

  const NewAddressPage({Key? key, this.addressId}) : super(key: key);

  @override
  State<NewAddressPage> createState() => _NewAddressPageState();
}

class _NewAddressPageState extends State<NewAddressPage> {
  late final NewAddressBloc _bloc;
  late final TextEditingController addressNameTextController;
  late final TextEditingController addressNoteTextController;
  late final TextEditingController consigneeNameTextController;
  late final TextEditingController phoneNumberTextController;
  ValueNotifier<bool> defaultNotifier = ValueNotifier(false);
  ValueNotifier<bool> allFieldValid = ValueNotifier(false);
  bool currentDefault = false;
  GeoResultEntity? geoResultEntity;
  double? currentLatitude;
  double? currentLongitude;

  @override
  void initState() {
    super.initState();
    _bloc = ServiceLocator.sl<NewAddressBloc>();
    addressNameTextController = TextEditingController();
    addressNoteTextController = TextEditingController();
    consigneeNameTextController = TextEditingController();
    phoneNumberTextController = TextEditingController();
    if (widget.addressId != null) {
      _bloc.add(NewAddressLoadInformation(addressId: widget.addressId!));
    } else {
      final userState = context.read<UserBloc>().state;
      if (userState is UserLoadSuccess) {
        consigneeNameTextController.text =
            "${userState.user.firstName} ${userState.user.lastName}";
        phoneNumberTextController.text = userState.user.phoneNumber ?? "";
      }
    }
  }

  @override
  void dispose() {
    _bloc.close();
    addressNoteTextController.dispose();
    addressNameTextController.dispose();
    consigneeNameTextController.dispose();
    phoneNumberTextController.dispose();
    super.dispose();
  }

  String? getErrorText(
    String text,
    FieldType type,
  ) {
    checkValidField();
    if (type == FieldType.firstName && !ValidateFieldUtil.validateName(text)) {
      return "Name is not valid";
    } else if (type == FieldType.phone &&
        !ValidateFieldUtil.validatePhone(text)) {
      return "Phone number is not valid";
    } else if (type == FieldType.address &&
        !ValidateFieldUtil.validateAddress(text)) {
      return "Address is not valid";
    }
    return null;
  }

  void checkValidField() {
    if (ValidateFieldUtil.validateName(
            consigneeNameTextController.text.trim()) &&
        ValidateFieldUtil.validatePhone(
            phoneNumberTextController.text.trim()) &&
        ValidateFieldUtil.validateAddress(
            addressNameTextController.text.trim())) {
      allFieldValid.value = true;
    } else {
      allFieldValid.value = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _bloc,
      child: BlocConsumer<NewAddressBloc, NewAddressState>(
        listener: (context, state) {
          switch (state) {
            case NewAddressLoadSuccess():
              addressNameTextController.text = state.address.detail ?? "";
              addressNoteTextController.text = state.address.note ?? "";
              consigneeNameTextController.text =
                  state.address.recipientName ?? "";
              phoneNumberTextController.text = state.address.phoneNumber ?? "";
              defaultNotifier.value = state.address.isDefault ?? false;
              currentDefault = state.address.isDefault ?? false;
              currentLatitude = state.address.latitude;
              currentLongitude = state.address.longitude;
          checkValidField();
            case NewAddressFinished():
              NavigationUtil.pop(result: true);
              break;
          }
        },
        builder: (context, state) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              title: Text(widget.addressId == null
                  ? "Add New Address"
                  : "Update Address"),
              centerTitle: true,
              bottom: const PreferredSize(
                preferredSize: Size.fromHeight(1),
                child: Divider(height: 1),
              ),
              actions: [
                widget.addressId != null
                    ? IconButton(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onPressed: defaultNotifier.value == false
                            ? () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext contextDialog) =>
                                        MyConfirmDialog(
                                            title: "",
                                            content: "Delete this address",
                                            callbackOK: () {
                                              //Để trong này vẫn xóa được phần tử nhưng pop ra màn hình trắng
                                              context
                                                  .read<NewAddressBloc>()
                                                  .add(NewAddressDoDelete(
                                                      addressId:
                                                          widget.addressId!));
                                              Navigator.pop(contextDialog);
                                            },
                                            callbackCancel: () {
                                              Navigator.pop(contextDialog);
                                            }));
                              }
                            : () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext dialogContext) =>
                                        MyAlertDialog(
                                            title: "",
                                            content:
                                                "To delete this default address, please create another address and set it default",
                                            callback: () {
                                              Navigator.pop(dialogContext);
                                            }));
                              },
                        icon: Icon(
                          Icons.delete_outline_rounded,
                          color: AppColor.primaryColor,
                        ),
                      )
                    : const SizedBox()
              ],
            ),
            body: Container(
              color: const Color(0xffEFEBE9),
              child: Column(
                children: [
                  const SizedBox(
                    height: AppDimen.spacing,
                  ),
                  Container(
                    color: Colors.white,
                    padding: const EdgeInsets.all(AppDimen.spacing),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            children: [
                              InkWell(
                                  onTap: () async {
                                    if (await PermissionUtil
                                            .requestLocationPermission() ==
                                        true) {
                                      // Navigator.pushNamed(context,
                                      //         AppRouter.geolocationRoute)
                                      //     .then((value) {
                                      //   if (value != null) {
                                      //     context.read<NewAddressBloc>().add(
                                      //         AddLocation(
                                      //             placeSearch:
                                      //                 value as PlaceSearch));
                                      //   }
                                      //   ;
                                      // });
                                      NavigationUtil.pushNamed(
                                              ChooseAddressPage.route)
                                          .then((geoResult) {
                                        if (geoResult != null) {
                                          geoResultEntity =
                                              geoResult as GeoResultEntity;
                                          addressNameTextController.text =
                                              geoResultEntity
                                                      ?.formattedAddress ??
                                                  "";
                                        }
                                      });
                                    }
                                  },
                                  child: TextInputField(
                                    title: "Address Name",
                                    hint: "Choose address",
                                    validateField: (String value) =>
                                        getErrorText(value, FieldType.address),
                                    controller: addressNameTextController,
                                    isEnable: false,
                                  )),
                              const SizedBox(
                                height: 12,
                              ),
                              TextInputField(
                                  title: "Address Note (Optional)",
                                  hint: "Enter address note",
                                  validateField: (String value) =>
                                      getErrorText(value, FieldType.note),
                                  controller: addressNoteTextController)
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: AppDimen.spacing,
                  ),
                  Container(
                    padding: const EdgeInsets.all(AppDimen.spacing),
                    color: Colors.white,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            children: [
                              NameInputField(
                                title: "Consignee Name",
                                hint: "Enter Consignee Name",
                                validateField: (String value) =>
                                    getErrorText(value, FieldType.address),
                                controller: consigneeNameTextController,
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              PhoneInputField(
                                title: "Phone Number",
                                hint: "Enter Phone Number",
                                validateField: (String value) =>
                                    getErrorText(value, FieldType.phone),
                                controller: phoneNumberTextController,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: AppDimen.spacing,
                  ),
                  ValueListenableBuilder(
                    valueListenable: defaultNotifier,
                    builder:
                        (BuildContext context, bool isDefault, Widget? child) {
                      return buildDefaultSwitch(widget.addressId, isDefault, currentDefault,
                          callback: (bool value) {
                        defaultNotifier.value = value;
                      }, showMyDialog: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext dialogContext) =>
                                MyAlertDialog(
                                    title: "",
                                    content:
                                        "To cancel this default address, please choose another address to set it default",
                                    callback: () {
                                      Navigator.pop(dialogContext);
                                    }));
                      });
                    },
                  ),
                  const Spacer(
                    flex: 1,
                  ),
                  ValueListenableBuilder(
                    valueListenable: allFieldValid,
                    builder: (BuildContext context, bool value, Widget? child) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.all(AppDimen.screenPadding),
                        child: ElevatedButton(
                          onPressed: allFieldValid.value == true
                              ? () {
                                  if (widget.addressId == null) {
                                    context.read<NewAddressBloc>().add(
                                        NewAddressDoCreate(
                                            address: AddressEntity(
                                                detail:
                                                    addressNameTextController
                                                        .text
                                                        .trim(),
                                                latitude: geoResultEntity?.lat,
                                                longitude: geoResultEntity?.lng,
                                                note: addressNoteTextController
                                                    .text
                                                    .trim(),
                                                recipientName:
                                                    consigneeNameTextController
                                                        .text
                                                        .trim(),
                                                phoneNumber: FormatUtil
                                                    .formatOriginalPhone(
                                                        phoneNumberTextController
                                                            .text
                                                            .trim()))));
                                  } else {
                                    context.read<NewAddressBloc>().add(
                                        NewAddressDoUpdate(
                                            address: AddressEntity(
                                                isDefault:
                                                    defaultNotifier.value,
                                                id: widget.addressId,
                                                detail:
                                                    addressNameTextController
                                                        .text
                                                        .trim(),
                                                latitude: geoResultEntity?.lat ?? currentLatitude,
                                                longitude: geoResultEntity?.lng ?? currentLongitude,
                                                note: addressNoteTextController
                                                    .text
                                                    .trim(),
                                                recipientName:
                                                    consigneeNameTextController
                                                        .text
                                                        .trim(),
                                                phoneNumber: FormatUtil
                                                    .formatOriginalPhone(
                                                        phoneNumberTextController
                                                            .text
                                                            .trim()))));
                                  }
                                }
                              : null,
                          child: const Text("Finish"),
                          style: AppStyle.elevatedButtonStylePrimary,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
