part of account;

class MenuItem extends StatelessWidget {
  final IconData iconData;
  final String content;
  final VoidCallback callback;

  const MenuItem({
    super.key,
    required this.iconData,
    required this.content,
    required this.callback,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: callback,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8.0),
        child: Row(
          children: [
            Icon(iconData),
            const SizedBox(
              width: 8,
            ),
            Expanded(
                child: Text(
                  content,
                  style: AppStyle.mediumTextStyleDark,
                )),
            const Icon(Icons.keyboard_arrow_right_rounded)
          ],
        ),
      ),
    );
  }
}