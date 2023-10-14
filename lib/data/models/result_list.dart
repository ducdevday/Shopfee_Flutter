class ResultList {
  final bool success;
  final String message;
  final List<dynamic>? data;

  ResultList({required this.success, required this.message, this.data});
}
