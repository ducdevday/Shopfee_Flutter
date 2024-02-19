part of otp;

class OtpBox extends StatefulWidget {
  final int index;
  final bool isLast;

  const OtpBox(
      {required this.index, this.isLast = false});

  @override
  State<OtpBox> createState() => _OtpBoxState();
}

class _OtpBoxState extends State<OtpBox> {
  final FocusNode _textFieldFocus = FocusNode();
  Color _color = const Color(0xffF0F0F0);
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    _textFieldFocus.addListener(() {
      if (_textFieldFocus.hasFocus) {
        setState(() {
          _color = Colors.white;
        });
      } else {
        setState(() {
          if (_controller.text.isEmpty) {
            _color = Color(0xffF0F0F0);
          } else {
            _color = Colors.white;
          }
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 46,
      height: 56,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16), color: Color(0xffF0F0F0)),
      child: TextField(
        onChanged: (value) => {
          context.read<OtpCubit>().addOTP(_controller.text, widget.index),
          // context.read<OtpCubit>().a
          if (widget.isLast == false && _controller.text.isNotEmpty)
            {FocusScope.of(context).nextFocus()}
        },
        focusNode: _textFieldFocus,
        style: TextStyle(fontSize: 20),
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly
        ],
        controller: _controller,
        decoration: InputDecoration(
          fillColor: _color,
          filled: true,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: _controller.text.isEmpty
                ? BorderSide.none
                : BorderSide(color: AppColor.primaryColor),
          ),
          border: OutlineInputBorder(
              borderSide: BorderSide(color: AppColor.primaryColor),
              borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }
}
