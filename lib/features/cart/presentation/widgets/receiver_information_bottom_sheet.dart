part of cart;

class ReceiverInformationBottomSheet extends StatefulWidget {
  const ReceiverInformationBottomSheet({
    super.key,
  });

  @override
  State<ReceiverInformationBottomSheet> createState() =>
      _ReceiverInformationBottomSheetState();
}

class _ReceiverInformationBottomSheetState
    extends State<ReceiverInformationBottomSheet> {
  late final TextEditingController consigneeNameTextController;
  late final TextEditingController phoneNumberTextController;
  var existPhoneNumber = false;
  ValueNotifier<bool> allFieldValid = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    consigneeNameTextController = TextEditingController();
    phoneNumberTextController = TextEditingController();
    final cartState = context.read<CartBloc>().state;
    if (cartState is CartLoaded) {
      consigneeNameTextController.text =
          "${cartState.cart.receiverOnsite?.recipientName}";
      phoneNumberTextController.text =
          "${cartState.cart.receiverOnsite?.phoneNumber ?? ""}";
      if (cartState.cart.receiverOnsite?.phoneNumber != null) {
        existPhoneNumber = true;
      }
    }
  }

  @override
  void dispose() {
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
            phoneNumberTextController.text.trim())) {
      allFieldValid.value = true;
    } else {
      allFieldValid.value = false;
    }
  }

  void handleSaveReceiverInformation(BuildContext context) {
    final ReceiverOnsiteEntity receiverInformation = ReceiverOnsiteEntity(
        recipientName: consigneeNameTextController.text.trim(),
        phoneNumber: FormatUtil.formatOriginalPhone(
            phoneNumberTextController.text.trim()));
    context.read<CartBloc>().add(
        CartLoadReceiverInformation(receiverInformation: receiverInformation));
    if (existPhoneNumber == false) {
      showDialog(
          context: context,
          builder: (BuildContext contextDialog) => MyConfirmDialog(
              title: "Update Phone Number",
              content: "Do you want to use this phone number as default",
              callbackOK: () async {
                context.read<UserBloc>().add(UserUpdatePhoneNumber(
                    phoneNumber: FormatUtil.formatOriginalPhone(
                        phoneNumberTextController.text.trim())));
                Navigator.pop(contextDialog);
              },
              callbackCancel: () {
                Navigator.pop(contextDialog);
              })).then((value) => Navigator.pop(context));
    } else {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        if (state is CartLoaded) {
          return SingleChildScrollView(

            child: Column(
              children: [
                SizedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Visibility(
                        visible: false,
                        maintainSize: true,
                        maintainAnimation: true,
                        maintainState: true,
                        child: IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.close_rounded)),
                      ),
                      Text(
                        "Receiver Information",
                        style: AppStyle.mediumTitleStyleDark,
                      ),
                      IconButton(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.close_rounded))
                    ],
                  ),
                ),
                SizedBox(
                  height: AppDimen.spacing,
                ),
                Padding(
                  padding: const EdgeInsets.all(AppDimen.spacing),
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
                ),
                SizedBox(
                  height: AppDimen.spacing,
                ),
                ValueListenableBuilder(
                  valueListenable: allFieldValid,
                  builder: (BuildContext context, bool isValid, Widget? child) {
                    return Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.symmetric(
                            horizontal: AppDimen.spacing),
                        child: ElevatedButton(
                          onPressed: isValid
                              ? () {
                                  handleSaveReceiverInformation(context);
                                }
                              : null,
                          child: const Text("Save"),
                          style: AppStyle.elevatedButtonStylePrimary,
                        ));
                  },
                ),
                SizedBox(
                  height: AppDimen.spacing,
                ),
              ],
            ),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
