part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();
}

class HomeInitial extends HomeState {
  @override
  List<Object> get props => [];
}

class HomeLoading extends HomeState {
  @override
  List<Object> get props => [];
}

class HomeLoaded extends HomeState {
  final List<Category> categories;
  final String? categoryChosenId;
  final List<ProductInformation> products;

  const HomeLoaded({
    required this.categories,
    this.categoryChosenId,
    required this.products,
  });

  @override
  List<Object> get props => [categories,  products];

  @override
  String toString() {
    return 'HomeLoaded{' +
        ' categories: $categories,' +
        ' categoryChosenId: $categoryChosenId,' +
        ' products: $products,' +
        '}';
  }

  HomeLoaded copyWith({
    List<Category>? categories,
    String? categoryChosenId,
    List<ProductInformation>? products,
  }) {
    return HomeLoaded(
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

  factory HomeLoaded.fromMap(Map<String, dynamic> map) {
    return HomeLoaded(
      categories: map['categories'] as List<Category>,
      categoryChosenId: map['categoryChosenId'] as String,
      products: map['products'] as List<ProductInformation>,
    );
  }
}

class HomeError extends HomeState {
  @override
  List<Object> get props => [];
}
