part of home;

abstract class HomeState extends Equatable {
  const HomeState();
}

class HomeInitial extends HomeState {
  @override
  List<Object> get props => [];
}

class HomeLoadInProcess extends HomeState {
  @override
  List<Object> get props => [];
}

class HomeLoadSuccess extends HomeState {
  final List<BannerEntity> banners;
  final List<CategoryEntity> categories;
  final List<ProductInformationEntity> topSellingProducts;
  final List<ProductInformationEntity> outstandingProducts;

  const HomeLoadSuccess({
    required this.banners,
    required this.categories,
    required this.topSellingProducts,
    required this.outstandingProducts,
  });

  @override
  List<Object> get props =>
      [banners, categories, topSellingProducts, outstandingProducts];
}

class HomeLoadError extends HomeState {
  @override
  List<Object> get props => [];
}
