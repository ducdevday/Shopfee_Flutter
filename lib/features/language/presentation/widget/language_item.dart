part of language;

class LanguageItem extends StatelessWidget {
  const LanguageItem(
      {super.key,
      required this.isSelected,
      required this.language,
      required this.onTap});

  final bool isSelected;
  final LanguageEntity language;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          color: isSelected ? AppColor.primaryColorLight : AppColor.lightColor,
          borderRadius: BorderRadius.circular(28),
          border: Border.all(color: isSelected ? Colors.transparent : AppColor.primaryColor)
        ),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 11),
        child: Row(
          children: [
            Image.asset(
              language.icon,
              width: 28,
              height: 28,
            ),
            const SizedBox(width: 16),
            Text(
              language.languageName.tr(),
              style: isSelected
                  ? AppStyle.normalTextStyle
                  : AppStyle.normalTextStyleDark,
            ),
          ],
        ),
      ),
    );
  }
}
