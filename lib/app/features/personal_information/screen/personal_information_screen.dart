import 'package:flutter/material.dart';
import 'package:shopfee/app/config/color.dart';
import 'package:shopfee/app/config/dimens.dart';
import 'package:shopfee/app/config/style.dart';

class PersonalInformation extends StatefulWidget {
  const PersonalInformation({Key? key}) : super(key: key);

  @override
  State<PersonalInformation> createState() => _PersonalInformationState();
}

class _PersonalInformationState extends State<PersonalInformation> {
  DateTime selectedDate = DateTime.now();

  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Information"),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Divider(height: 1),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(AppDimen.screenPadding),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Align(
                alignment: Alignment.center,
                child: Stack(
                  children: [
                    Container(
                      width: 110,
                      height: 110,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                "https://scontent.fsgn2-7.fna.fbcdn.net/v/t39.30808-6/336771326_220248634014600_7812303016188866708_n.jpg?_nc_cat=100&ccb=1-7&_nc_sid=49d041&_nc_ohc=oqP_l9CXr7AAX-HbVWV&_nc_ht=scontent.fsgn2-7.fna&oh=00_AfBkCGmhOd2F8Xti8G5xRuw3ePENsmCkCIATrNqG8QRtQg&oe=651D26ED",
                              ))),
                    ),
                    Container(
                        margin: EdgeInsets.only(top: 85, left: 75),
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            border: Border.fromBorderSide(
                                BorderSide(color: AppColor.nonactiveColor))),
                        child: Icon(
                          Icons.camera_alt,
                          size: 16,
                        )),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: InputField(
                      title: "First Name",
                      hint: "Input Your First Name",
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    flex: 1,
                    child: InputField(
                      title: "Last Name",
                      hint: "Input Your Last Name",
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: AppDimen.spacing,
              ),
              const InputField(
                title: "Email",
                hint: "mingduc17082002@gmail.com",
                isEnable: false,
              ),
              const SizedBox(
                height: AppDimen.spacing,
              ),
              const InputField(
                title: "Phone",
                hint: "033901237",
                isEnable: false,
              ),
              const SizedBox(
                height: AppDimen.spacing,
              ),
              Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Birthday",
                      style: AppStyle.normalTextStyle
                          .copyWith(color: Color(0xff3C3C3C)),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    onTap: () {
                      _selectDate(context);
                    },
                    child: TextField(
                      enabled: false,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 8, horizontal: 12),
                        suffixIcon: const Icon(Icons.calendar_month_outlined),
                        disabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(16)),
                        hintText: "Choose your birthday",
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: AppDimen.spacing,
              ),
              Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Gender",
                      style: AppStyle.normalTextStyle
                          .copyWith(color: Color(0xff3C3C3C)),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    onTap: () {
                      showDialog(
                          context: context, builder: (BuildContext context) {
                        return SimpleDialog(
                          title: const Text('Select your gender'),
                          children: <Widget>[
                            SimpleDialogOption(
                              onPressed: () {
                              },
                              child: const Text('Male   ♂️'),
                            ),
                            SimpleDialogOption(
                              onPressed: () {
                              },
                              child: const Text('Female   ♀️'),
                            ),
                          ],
                        );
                      });
                    },
                    child: TextField(
                      enabled: false,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 8, horizontal: 12),
                        suffixIcon: const Icon(Icons.arrow_drop_down),
                        disabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(16)),
                        hintText: "Male",
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 40,),
              Align(
                  alignment: Alignment.center,
                  child: Container(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Text("Update"),
                        style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                                vertical: 16, horizontal: 24),
                            disabledBackgroundColor: const Color(0xffCACACA),
                            disabledForegroundColor: AppColor.lightColor,
                            textStyle: AppStyle.mediumTextStyleDark,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            )),
                      )))
            ],
          ),
        ),
      ),
    );
  }
}

class InputField extends StatefulWidget {
  final String title;
  final String hint;
  final bool isEnable;

  const InputField({
    required this.title,
    required this.hint,
    this.isEnable = true,
  });

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            widget.title,
            style: AppStyle.normalTextStyle.copyWith(color: Color(0xff3C3C3C)),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) {
            // context.read<RegisterCubit>()
            //     .addField(widget.title, _controller.text);
            if (value!.isEmpty) {
              return 'Please fill this section';
            }
            return null;
          },
          enabled: widget.isEnable,
          controller: _controller,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
            hintText: widget.hint,
          ),
        ),
      ],
    );
  }
}
