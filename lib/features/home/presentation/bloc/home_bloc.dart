part of home;

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeUseCase _homeUseCase;

  HomeBloc(this._homeUseCase) : super(HomeInitial()) {
    on<HomeLoadInformation>(_onHomeLoadInformation);
    on<HomeRefreshInformation>(_onHomeRefreshInformation);
  }

  FutureOr<void> _onHomeLoadInformation(
      HomeLoadInformation event, Emitter<HomeState> emit) async {
    try {
      emit(HomeLoadInProcess());
      if (SharedService.getUserId() != null) {
        final response = await Future.wait([
          _homeUseCase.getAllBanner(),
          _homeUseCase.getAllCategory(),
          _homeUseCase.getTopSellingProduct(quantity: 8),
          _homeUseCase.getOutStandingProduct(quantity: 8),
          _homeUseCase.getViewedProduct(quantity: 8),
          _homeUseCase.getNewestBlog(quantity: 8)
        ]);
        var banners = response[0] as List<BannerEntity>;
        final categories = response[1] as List<CategoryEntity>;
        final topSellingProducts =
            response[2] as List<ProductInformationEntity>;
        final outStandingProducts =
            response[3] as List<ProductInformationEntity>;
        final viewedProducts = response[4] as List<ProductInformationEntity>;
        final newestBlogs = response[5] as List<BlogInformationEntity>;
        await Future.delayed(Duration(seconds: 1));
        emit(HomeLoadSuccess(
            banners: banners,
            categories: categories,
            topSellingProducts: topSellingProducts,
            outstandingProducts: outStandingProducts,
            viewedProducts: viewedProducts,
            newestBlogs: newestBlogs));
      }
      else{
        final response = await Future.wait([
          _homeUseCase.getAllBanner(),
          _homeUseCase.getAllCategory(),
          _homeUseCase.getTopSellingProduct(quantity: 8),
          _homeUseCase.getOutStandingProduct(quantity: 8),
          _homeUseCase.getNewestBlog(quantity: 8)
        ]);
        var banners = response[0] as List<BannerEntity>;
        final categories = response[1] as List<CategoryEntity>;
        final topSellingProducts =
        response[2] as List<ProductInformationEntity>;
        final outStandingProducts =
        response[3] as List<ProductInformationEntity>;
        final newestBlogs = response[4] as List<BlogInformationEntity>;
        await Future.delayed(Duration(seconds: 1));
        emit(HomeLoadSuccess(
            banners: banners,
            categories: categories,
            topSellingProducts: topSellingProducts,
            outstandingProducts: outStandingProducts,
            viewedProducts: [],
            newestBlogs: newestBlogs));
      }
    } catch (e) {
      emit(HomeLoadError());
    }
  }

  FutureOr<void> _onHomeRefreshInformation(
      HomeRefreshInformation event, Emitter<HomeState> emit) async {
    try {
      if (SharedService.getUserId() != null) {
        final response = await Future.wait([
          _homeUseCase.getAllBanner(),
          _homeUseCase.getAllCategory(),
          _homeUseCase.getTopSellingProduct(quantity: 8),
          _homeUseCase.getOutStandingProduct(quantity: 8),
          _homeUseCase.getViewedProduct(quantity: 8),
          _homeUseCase.getNewestBlog(quantity: 8)
        ]);
        var banners = response[0] as List<BannerEntity>;
        final categories = response[1] as List<CategoryEntity>;
        final topSellingProducts =
        response[2] as List<ProductInformationEntity>;
        final outStandingProducts =
        response[3] as List<ProductInformationEntity>;
        final viewedProducts = response[4] as List<ProductInformationEntity>;
        final newestBlogs = response[5] as List<BlogInformationEntity>;
        await Future.delayed(Duration(seconds: 1));
        emit(HomeLoadSuccess(
            banners: banners,
            categories: categories,
            topSellingProducts: topSellingProducts,
            outstandingProducts: outStandingProducts,
            viewedProducts: viewedProducts,
            newestBlogs: newestBlogs));
      }
      else{
        final response = await Future.wait([
          _homeUseCase.getAllBanner(),
          _homeUseCase.getAllCategory(),
          _homeUseCase.getTopSellingProduct(quantity: 8),
          _homeUseCase.getOutStandingProduct(quantity: 8),
          _homeUseCase.getNewestBlog(quantity: 8)
        ]);
        var banners = response[0] as List<BannerEntity>;
        final categories = response[1] as List<CategoryEntity>;
        final topSellingProducts =
        response[2] as List<ProductInformationEntity>;
        final outStandingProducts =
        response[3] as List<ProductInformationEntity>;
        final newestBlogs = response[4] as List<BlogInformationEntity>;
        emit(HomeLoadSuccess(
            banners: banners,
            categories: categories,
            topSellingProducts: topSellingProducts,
            outstandingProducts: outStandingProducts,
            viewedProducts: [],
            newestBlogs: newestBlogs));
      }
    } catch (e) {
      emit(HomeLoadError());
    }
  }
}
