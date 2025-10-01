import 'dart:async';

class DeBouncer {
  final int milliseconds;
  Timer? _timer;

  DeBouncer({this.milliseconds = 500});

  void run(FutureOr<void> Function() action) {
    _timer?.cancel();
    _timer = Timer(Duration(milliseconds: milliseconds), () {
      final result = action();
      if (result is Future) {
        result.catchError((e, st) {});
      }
    });
  }

  void dispose() {
    _timer?.cancel();
    _timer = null;
  }
}
