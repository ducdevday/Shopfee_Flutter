import 'package:shopfee/core/common/enum/review_sort_type.dart';

extension ReviewTypeExtension on ReviewSortType{
  String getFormattedName() {
    switch (this) {
      case ReviewSortType.CREATED_AT_DESC:
        return "New to old created time";
      case ReviewSortType.CREATED_AT_ASC:
        return "Old to new created time";
      case ReviewSortType.STAR_DESC:
        return "High to low rating";
      case ReviewSortType.STAR_ASC:
        return "Low to high rating";
      default:
        return "";
    }
  }
}