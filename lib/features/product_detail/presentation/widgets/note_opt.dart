part of product_detail;

class NoteOpt extends StatelessWidget {
  const NoteOpt({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductDetailBloc, ProductDetailState>(
      builder: (context, state) {
        if (state is ProductDetailLoadSuccess) {
          return TextFormField(
            initialValue: state.order.note.isNotEmpty ? state.order.note : null,
            onChanged: (value) => {
              context
                  .read<ProductDetailBloc>()
                  .add(ProductDetailTakeNote(value))
            },
            style: TextStyle(fontSize: 14),
            maxLength: 50,
            decoration: InputDecoration(
              counterText: "${state.order.note.length}/50",
              contentPadding: EdgeInsets.all(8),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xffCCCCCC)),
                  borderRadius: BorderRadius.circular(8)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xffCCCCCC)),
                  borderRadius: BorderRadius.circular(8)),
              hintText: "Optional",
            ),
          );
        } else {
          return SizedBox();
        }
      },
    );
  }
}
