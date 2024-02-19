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
  final String? categoryChosenId;
  final List<ProductInformationEntity> products;

  const HomeLoadSuccess({
    required this.categories,
    this.categoryChosenId,
    required this.products,
  });

  @override
  List<Object> get props => [categories, products];

  @override
  String toString() {
    return 'HomeLoaded{' +
        ' categories: $categories,' +
        ' categoryChosenId: $categoryChosenId,' +
        ' products: $products,' +
        '}';
  }

  HomeLoadSuccess copyWith({
    List<CategoryEntity>? categories,
    String? categoryChosenId,
    List<ProductInformationEntity>? products,
  }) {
    return HomeLoadSuccess(
      categories: categories ?? this.categories,
      categoryChosenId: categoryChosenId ?? this.categoryChosenId,
      products: products ?? this.products,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'categories': this.categories,
      'categoryChosenId': this.categoryChosenId,
      'products': this.products,
    };
  }

  factory HomeLoadSuccess.fromMap(Map<String, dynamic> map) {
    return HomeLoadSuccess(
      categories: map['categories'] as List<CategoryEntity>,
      categoryChosenId: map['categoryChosenId'] as String,
      products: map['products'] as List<ProductInformationEntity>,
    );
  }
}

class HomeLoadError extends HomeState {
  @override
  List<Object> get props => [];
}
