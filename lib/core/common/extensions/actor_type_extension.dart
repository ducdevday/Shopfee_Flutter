import 'package:shopfee/core/common/enum/actor_type.dart';

extension ActorTypeExtension on ActorType {
  String getFormattedName() {
    switch (this) {
      case ActorType.USER:
        return "Customer";
      case ActorType.EMPLOYEE:
        return "Employee";
      case ActorType.AUTOMATIC:
        return "Automation";
    }
  }
}
