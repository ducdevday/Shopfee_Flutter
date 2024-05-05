part of cart;

class CartItemContainerWidget extends StatelessWidget {
  final Widget child;
  const CartItemContainerWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(AppDimen.screenPadding),
      child: child,
    );
  }
}
