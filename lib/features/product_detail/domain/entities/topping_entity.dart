import 'package:equatable/equatable.dart';
import 'package:shopfee/features/product_detail/data/models/topping_model.dart';

class ToppingEntity extends Equatable {
  final String name;
  final double price;

  ToppingEntity({required this.name, required this.price});

  factory ToppingEntity.fromModel(ToppingModel model){
    return ToppingEntity(name: model.name!, price: model.price!);
  }

  @override
  List<Object> get props => [name, price];
}
