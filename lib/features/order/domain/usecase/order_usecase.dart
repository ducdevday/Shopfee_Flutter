import 'package:shopfee/core/errors/app_exception.dart';
import 'package:shopfee/features/home/domain/entities/category_entity.dart';
import 'package:shopfee/features/home/domain/entities/product_infomation_entity.dart';
import 'package:shopfee/features/order/domain/repositories/order_repository.dart';
import 'package:shopfee/features/template/domain/entities/template_entity.dart';
import 'package:shopfee/features/template/domain/repositories/template_repository.dart';

abstract class OrderUseCase {
  Future<List<CategoryEntity>> getAllCategory();

  Future<List<ProductInformationEntity>> getProductsByCategoryId(String id,
      {required int page, required int size});
}

class OrderUseCaseImpl extends OrderUseCase {
  final OrderRepository _orderRepository;

  OrderUseCaseImpl(this._orderRepository);

  @override
  Future<List<CategoryEntity>> getAllCategory() async {
    return await _orderRepository.getAllCategory();
  }

  @override
  Future<List<ProductInformationEntity>> getProductsByCategoryId(String id,
      {required int page, required int size}) async {
    return await _orderRepository.getProductsByCategoryId(id,
        page: page, size: size);
  }
}
