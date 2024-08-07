part of new_address;

Widget buildDefaultSwitch(
    String? addressId, bool isDefault,bool currentDefault,
    {required Function(bool) callback, required VoidCallback showMyDialog}) {
  if (addressId != null) {
    return Container(
        padding: EdgeInsets.symmetric(
            vertical: AppDimen.spacing, horizontal: AppDimen.screenPadding),
        color: Colors.white,
        child: Row(
          children: [
            Text(R.setIsDefault.tr(), style: AppStyle.mediumTextStyleDark),
            Spacer(
              flex: 1,
            ),
            Switch(
              // This bool value toggles the switch.
              value: isDefault,
              activeColor: AppColor.primaryColor,
              onChanged: currentDefault == true
                  ? (bool value) {
                      showMyDialog();
                    }
                  : (bool value) {
                      if (value == true) {
                        callback(true);
                      } else {
                        callback(false);
                      }
                    },
            )
          ],
        ));
  }
  return SizedBox();
}
