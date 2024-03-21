part of home;

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeUseCase _homeUseCase;

  HomeBloc(this._homeUseCase) : super(HomeInitial()) {
    on<HomeLoadInformation>(_onHomeLoadInformation);
  }

  FutureOr<void> _onHomeLoadInformation(
      HomeLoadInformation event, Emitter<HomeState> emit) async {
    emit(HomeLoadInProcess());
    try {
      final response = await Future.wait([
        _homeUseCase.getAllBanner(),
        _homeUseCase.getAllCategory(),
        _homeUseCase.getTopSellingProduct(quantity: 8),
        _homeUseCase.getOutStandingProduct(quantity: 8)
      ]);
      var banners = response[0] as List<BannerEntity>;
      final categories = response[1] as List<CategoryEntity>;
      final topSellingProducts = response[2] as List<ProductInformationEntity>;
      final outStandingProducts = response[3] as List<ProductInformationEntity>;
      await Future.delayed(Duration(seconds: 1));

      emit(HomeLoadSuccess(
          banners: banners,
          categories: categories,
          topSellingProducts: topSellingProducts,
          outstandingProducts: outStandingProducts));
    } catch (e) {
      emit(HomeLoadError());
    }
  }
}
