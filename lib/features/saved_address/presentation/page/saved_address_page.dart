part of saved_address;

class SavedAddressPage extends StatefulWidget {
  static const String route = "/saved_address";
  final String fromRoute;

  const SavedAddressPage({Key? key, required this.fromRoute}) : super(key: key);

  @override
  State<SavedAddressPage> createState() => _SavedAddressPageState();
}

class _SavedAddressPageState extends State<SavedAddressPage> {
  late final SavedAddressBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = ServiceLocator.sl<SavedAddressBloc>()
      ..add(SavedAddressLoadInformation());
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  void checkAddNewAddress(
      SavedAddressLoadSuccess state, BuildContext context) async {
    if (state.addressList.length < 5) {
      NavigationUtil.pushNamed(NewAddressPage.route).then((refresh) {
        if (refresh != null && refresh as bool == true) {
          context.read<SavedAddressBloc>().add(SavedAddressLoadInformation());
        }
      });
    } else {
      showDialog(
          context: context,
          builder: (_) => MyAlertDialog(
              title: "",
              content: "You can only save less than or equal 5 address",
              callback: () {
                Navigator.pop(context);
              }));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffEFEBE9),
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(widget.fromRoute == CartPage.route
              ? "Choose Address"
              : "Saved Address"),
          centerTitle: true,
          bottom: const PreferredSize(
            preferredSize: Size.fromHeight(1),
            child: Divider(height: 1),
          ),
        ),
        body: SingleChildScrollView(
          child: BlocProvider(
            create: (context) => _bloc,
            child: BlocBuilder<SavedAddressBloc, SavedAddressState>(
              builder: (context, state) {
                if (state is SavedAddressLoadSuccess) {
                  return Column(
                    children: [
                      SizedBox(
                        height: AppDimen.spacing,
                      ),
                      Container(
                        color: Colors.white,
                        child: Column(
                          children: [
                            ListView.separated(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  if (widget.fromRoute == CartPage.route) {
                                    return InkWell(
                                      onTap: () {
                                        Navigator.pop(context,
                                            state.addressList[index].id);
                                      },
                                      child: buildAddressItem(
                                          state, index, context),
                                    );
                                  }
                                  return buildAddressItem(
                                      state, index, context);
                                },
                                separatorBuilder: (context, index) => Divider(
                                      height: 2,
                                      indent: 20,
                                    ),
                                itemCount: state.addressList.length),
                            Divider(
                              height: 1,
                            ),
                            TextButton.icon(
                                onPressed: () {
                                  checkAddNewAddress(state, context);
                                },
                                icon: Icon(Icons.add_circle_outline),
                                label: Text(
                                  "Add New Address",
                                  style: AppStyle.normalTextStylePrimary,
                                )),
                          ],
                        ),
                      )
                    ],
                  );
                } else {
                  return SizedBox();
                }
              },
            ),
          ),
        ));
  }

  Widget buildAddressItem(
      SavedAddressLoadSuccess state, int index, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          left: 26, right: 16, top: AppDimen.spacing, bottom: AppDimen.spacing),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          state.addressList[index].recipientName ?? "",
                          style: AppStyle.mediumTextStyleDark
                              .copyWith(color: AppColor.headingColor),
                        ),
                        Text(
                          "  |  ",
                          style: AppStyle.normalTextStyleDark,
                        ),
                        Text(
                          state.addressList[index].phoneNumber ?? "",
                          style: AppStyle.normalTextStyleDark,
                        ),
                      ],
                    ),
                    Text(
                      state.addressList[index].detail ?? "",
                      style: AppStyle.normalTextStyleDark,
                      overflow: TextOverflow.clip,
                    ),
                  ],
                ),
              ),
              IconButton(
                  onPressed: () {
                    NavigationUtil.pushNamed(NewAddressPage.route,
                            arguments: state.addressList[index].id)
                        .then((refresh) {
                      if (refresh != null && refresh as bool == true) {
                        context
                            .read<SavedAddressBloc>()
                            .add(SavedAddressLoadInformation());
                      }
                    });
                  },
                  icon: SvgPicture.asset(
                    AppPath.icEdit,
                    color: AppColor.primaryColor,
                  ))
            ],
          ),
          buildLabelDefault(state.addressList[index].isDefault!)
        ],
      ),
    );
  }

  Widget buildLabelDefault(bool isDefault) {
    if (isDefault) {
      return OutlinedButton(
          onPressed: null,
          child: Text("Default"),
          style: OutlinedButton.styleFrom(
              minimumSize: const Size(84, 26),
              disabledForegroundColor: AppColor.primaryColor,
              side: const BorderSide(width: 1, color: Color(0xff5D4037))));
    } else {
      return SizedBox();
    }
  }
}
