class CoinHistoryParams{
  final int page;
  final int size;

  const CoinHistoryParams({
    required this.page,
    required this.size,
  });

  Map<String, dynamic> toJson() {
    return {
      "page": this.page,
      "size": this.size,
    };
  }
}