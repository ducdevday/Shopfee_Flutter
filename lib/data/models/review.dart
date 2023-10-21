import 'package:equatable/equatable.dart';

class Review extends Equatable {
  final int? rating;
  final String? content;

  Review({this.rating, this.content});

  @override
  List<Object?> get props => [rating, content];

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      rating: json["rating"] as int,
      content: json["content"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "rating": this.rating,
      "content": this.content,
    };
  }
}
