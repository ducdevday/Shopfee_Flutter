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
  final List<CategoryEntity> categories;
  final List<ProductInformationEntity> products;

  const HomeLoadSuccess({
    required this.categories,
    required this.products,
  });

  @override
  List<Object> get props => [categories, products];
}

class HomeLoadError extends HomeState {
  @override
  List<Object> get props => [];
}
