import 'dart:io';

class RefundRequestParams{
  final String reason;
  final List<File> mediaList;
  final String? note;

  const RefundRequestParams({
    required this.reason,
    required this.mediaList,
    this.note,
  });
}