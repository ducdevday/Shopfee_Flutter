part of cart;

class BranchConflictBottomSheet extends StatefulWidget {
  const BranchConflictBottomSheet({
    super.key,
  });

  @override
  State<BranchConflictBottomSheet> createState() =>
      _BranchConflictBottomSheetState();
}

class _BranchConflictBottomSheetState extends State<BranchConflictBottomSheet> {
  CartInvalidBranch? chosenBranch;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        if (state is CartLoaded) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    "Choose Branch",
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(
                  "Because products don't available in some branch\nSo you must choose one",
                  style: AppStyle.normalTextStyleDark,
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: ListView.separated(
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Row(
                          children: [
                            Expanded(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  state.cart.cartInvalidBranchList[index]
                                      .branchName,
                                  style: AppStyle.normalTextStyleDark,
                                ),
                                Text(
                                  state.cart.cartInvalidBranchList[index]
                                      .invalidProductNameList
                                      .join(", "),
                                  style: AppStyle.smallTextStyleDark,
                                )
                              ],
                            )),
                            Radio<CartInvalidBranch>(
                                activeColor: AppColor.primaryColor,
                                value: state.cart.cartInvalidBranchList[index],
                                groupValue: chosenBranch,
                                onChanged: (CartInvalidBranch? value) {
                                  setState(() {
                                    chosenBranch = value;
                                  });
                                })
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const Divider(
                        height: 10,
                        indent: 10,
                        endIndent: 10,
                      );
                    },
                    itemCount: state.cart.cartInvalidBranchList.length),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width - 10 * 2,
                child: ElevatedButton(
                  onPressed: chosenBranch != null
                      ? () {
                          context.read<CartBloc>().add(
                              CartChooseBranchConflict(branch: chosenBranch!));
                          Navigator.pop(context);
                        }
                      : null,
                  child: Text("Confirm"),
                  style: AppStyle.elevatedButtonStylePrimary,
                ),
              ),
              SizedBox(
                height: 10,
              )
            ],
            // ),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
