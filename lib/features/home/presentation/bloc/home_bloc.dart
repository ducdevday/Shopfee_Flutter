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
        _homeUseCase.getAllCategory(),
        _homeUseCase.getTopSellingProduct(quantity: 8),
        _homeUseCase.getOutStandingProduct(quantity: 8)
      ]);
      var categories = response[0] as List<CategoryEntity>;
      var topSellingProducts = response[1] as List<ProductInformationEntity>;
      var outStandingProducts = response[2] as List<ProductInformationEntity>;
      await Future.delayed(Duration(seconds: 1));

      emit(HomeLoadSuccess(
          categories: categories,
          topSellingProducts: topSellingProducts,
          outstandingProducts: outStandingProducts));
    } catch (e) {
      emit(HomeLoadError());
    }
  }
}
