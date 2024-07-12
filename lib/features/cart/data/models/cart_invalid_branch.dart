class CartInvalidBranch{
  final String branchId;
  final String branchName;
  final List<String> invalidProductIdList;
  final List<String> invalidProductNameList;


  const CartInvalidBranch({
    required this.branchId,
    required this.branchName,
    required this.invalidProductIdList,
    required this.invalidProductNameList,
  });
}