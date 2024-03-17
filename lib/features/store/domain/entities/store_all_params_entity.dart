class StoreAllParamsEntity{
  final bool all;
  final double lat;
  final double lng;
  final int page;
  final int size;
  final String? key;

  const StoreAllParamsEntity({
    required this.all,
    required this.lat,
    required this.lng,
    required this.page,
    required this.size,
    this.key,
  });
}