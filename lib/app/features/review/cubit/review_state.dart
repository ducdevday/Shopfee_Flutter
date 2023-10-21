part of 'review_cubit.dart';

abstract class ReviewState extends Equatable {
  const ReviewState();
}

class ReviewInitial extends ReviewState {
  @override
  List<Object> get props => [];
}

class ReviewLoaded extends ReviewState {
  final int rating;
  final String content;

  ReviewLoaded({this.rating = 0, this.content = ""});

  @override
  List<Object> get props => [rating, content];

  bool get isValid => rating > 0;

  @override
  String toString() {
    return 'ReviewLoaded{' + ' rating: $rating,' + ' content: $content,' + '}';
  }

  ReviewLoaded copyWith({
    int? rating,
    String? content,
  }) {
    return ReviewLoaded(
      rating: rating ?? this.rating,
      content: content ?? this.content,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'rating': this.rating,
      'content': this.content,
    };
  }

  factory ReviewLoaded.fromMap(Map<String, dynamic> map) {
    return ReviewLoaded(
      rating: map['rating'] as int,
      content: map['content'] as String,
    );
  }
}

class ReviewFinished extends ReviewState {
  @override
  List<Object> get props => [];
}