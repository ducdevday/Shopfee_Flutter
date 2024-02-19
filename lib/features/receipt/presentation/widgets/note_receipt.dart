part of receipt;

class NoteReceipt extends StatelessWidget {
  const NoteReceipt({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReceiptBloc, ReceiptState>(
      builder: (context, state) {
        if (state is ReceiptLoadSuccess &&
            state.receipt.note != null &&
            state.receipt.note!.isNotEmpty) {
          return Column(
            children: [
              Container(
                height: 4,
                color: Color(0xffEFEBE9),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Note",
                          style: AppStyle.mediumTitleStyleDark
                              .copyWith(color: AppColor.headingColor)),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      initialValue: state.receipt.note,
                      enabled: false,
                      style: TextStyle(fontSize: 14),
                      decoration: InputDecoration(
                        disabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xffCCCCCC)),
                            borderRadius: BorderRadius.circular(8)),
                        contentPadding: EdgeInsets.all(8),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xffCCCCCC)),
                            borderRadius: BorderRadius.circular(8)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xffCCCCCC)),
                            borderRadius: BorderRadius.circular(8)),
                      ),
                    )
                  ],
                ),
              ),
            ],
          );
        } else {
          return SizedBox();
        }
      },
    );
  }
}
