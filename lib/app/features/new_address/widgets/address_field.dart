import 'package:flutter/material.dart';
import 'package:shopfee/app/config/style.dart';

class AddressField extends StatelessWidget {
  final String title;
  final String? defaultValue;
  final bool? isPhoneNumber;
  final Function(String) callback;

  const AddressField({
    super.key,
    required this.title,
    this.defaultValue = "",
    required this.callback,
    this.isPhoneNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AppStyle.mediumTextStyleDark),
        const SizedBox(
          height: 8,
        ),
        TextFormField(
          initialValue: defaultValue,
          onChanged: (value) => {callback(value)},
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) {
            if (value!.isEmpty && title != "Address Note") {
              return 'Please fill this section';
            } else if (isPhoneNumber == true) {
              RegExp regex = RegExp(r"^\d{10}$");
              if (!regex.hasMatch(value)) {
                return 'Phone number invalid';
              }
            }
            return null;
          },
          keyboardType: isPhoneNumber != null ? TextInputType.phone : null,
          style: TextStyle(fontSize: 14),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(8),
            focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xffCCCCCC)),
                borderRadius: BorderRadius.circular(8)),
            errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xffCCCCCC)),
                borderRadius: BorderRadius.circular(8)),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xffCCCCCC)),
                borderRadius: BorderRadius.circular(8)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xffCCCCCC)),
                borderRadius: BorderRadius.circular(8)),
            hintText: title,
          ),
        ),
      ],
    );
  }
}
