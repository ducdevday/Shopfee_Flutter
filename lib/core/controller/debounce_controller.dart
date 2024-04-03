import 'dart:async';
import 'dart:ui';

class DebounceController {
  final int milliseconds;
  Timer? _timer;

  DebounceController({this.milliseconds = 500});

  void run(VoidCallback action) {
    _timer?.cancel();
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }

  void dispose() {
    _timer?.cancel();
    _timer = null;
  }
}