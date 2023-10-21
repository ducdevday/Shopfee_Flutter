import 'package:shopfee/data/base/base_service.dart';
import 'package:shopfee/data/models/result.dart';

abstract class TransactionRepositoryBase extends BaseService{
    Future<Result> updateTransaction(String transactionId);
}
