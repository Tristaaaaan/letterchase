import 'dart:async';
import 'dart:ui';

class DeBouncer {
  final int milliseconds;
  Timer? _timer;

  DeBouncer({this.milliseconds = 500});

  void run(VoidCallback action) {
    _timer?.cancel();
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}
