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
  final List<ProductInformationEntity> viewedProducts;
  final List<BlogInformationEntity> newestBlogs;

  const HomeLoadSuccess({
    required this.banners,
    required this.categories,
    required this.topSellingProducts,
    required this.outstandingProducts,
    required this.viewedProducts,
    required this.newestBlogs,
  });

  @override
  List<Object> get props => [
        banners,
        categories,
        topSellingProducts,
        outstandingProducts,
        viewedProducts,
        newestBlogs
      ];
}

class HomeLoadError extends HomeState {
  @override
  List<Object> get props => [];
}
