part of order;

class SortItem<T> extends StatelessWidget {
  final String title;
  final T value;
  final T? groupValue;
  final Function(T?) callback;

  const SortItem({
    Key? key,
    required this.title,
    required this.value,
    required this.groupValue,
    required this.callback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: AppStyle.normalTextStyleDark,
        ),
        MyRadio(
          value: value,
          groupValue: groupValue,
          onChanged: (T? value) {
            callback(value);
          },
        ),
      ],
    );
  }
}
