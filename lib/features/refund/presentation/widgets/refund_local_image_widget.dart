part of refund;

class RefundLocalImageWidget extends StatelessWidget {
  final File image;

  const RefundLocalImageWidget({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 4,
      height: MediaQuery.of(context).size.width / 4,
      child: Stack(
        fit: StackFit.expand,
        children: [
          GestureDetector(
            onTap: () {
              NavigationUtil.pushNamed(LocalImageFullScreen.route,
                  arguments: image);
            },
            child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(12)),
                child: Hero(
                  tag: "IMG",
                  child: Image.file(
                    image,
                    fit: BoxFit.cover,
                  ),
                )),
          ),
          Positioned(
            right: 0,
            child: GestureDetector(
              onTap: (){
                context.read<RefundBloc>().add(RefundRemoveMedia(chosenMedia: image));
              },
              child: Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.7),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.close_rounded,
                    color: Colors.white,
                    size: 16,
                  )),
            ),
          )
        ],
      ),
    );
  }
}
