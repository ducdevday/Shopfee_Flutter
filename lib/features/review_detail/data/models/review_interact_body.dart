import 'package:shopfee/core/common/enum/review_interaction_type.dart';

class ReviewInteractBody{
  final String userId;
  final ReviewInteractionType type;

  const ReviewInteractBody({
    required this.userId,
    required this.type,
  });

  Map<String, dynamic> toJson() {
    return {
      "userId": this.userId,
      "interaction": this.type.name,
    };
  }
}