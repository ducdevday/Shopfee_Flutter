class Result {
  final bool success;
  final String message;
  final Map<String, dynamic>? data;

  Result({required this.success, required this.message, this.data});
}
