import 'package:shopfee/features/receipt/data/models/branch_model.dart';

class BranchEntity {
  final String? id;
  final String? address;

  const BranchEntity({
    this.id,
    this.address,
  });

  factory BranchEntity.fromModel(BranchModel model) {
    return BranchEntity(id: model.id, address: model.address);
  }

}
