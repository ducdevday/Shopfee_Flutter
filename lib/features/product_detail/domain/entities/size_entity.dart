import 'package:equatable/equatable.dart';
import 'package:shopfee/features/product_detail/data/models/size_model.dart';

class SizeEntity extends Equatable {
  final String size;
  final double price;

  SizeEntity({required this.size, required this.price});

  factory SizeEntity.fromModel(SizeModel model){
    return SizeEntity(size: model.size!, price: model.price!);
  }

  @override
  List<Object> get props => [size, price];
}