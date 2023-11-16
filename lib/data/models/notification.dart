class Announce {
  final String title;
  final String body;
  final String? image; // có thể null
  final DateTime createdAt;
  final String userId;
  final String destinationId;
  final bool isRead;

  const Announce({
    required this.title,
    required this.body,
    this.image,
    required this.createdAt,
    required this.userId,
    required this.destinationId,
    this.isRead = false,
  });
}
