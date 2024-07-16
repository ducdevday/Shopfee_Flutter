import 'package:shopfee/features/receipt/data/models/cashier_model.dart';

class CashierEntity{
  final String id;
  final String name;

  const CashierEntity({
    required this.id,
    required this.name,
  });

  factory CashierEntity.fromModel(CashierModel cashier) {
    return CashierEntity(
      id: cashier.id,
      name: cashier.name,
    );
  }
}