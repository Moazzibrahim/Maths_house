// ignore_for_file: file_names

import 'dart:async';
import 'package:flutter/foundation.dart';

class TimerProvider with ChangeNotifier {
  int _secondsSpent = 0; // Total seconds spent
  Timer? _timer;

  int get secondsSpent => _secondsSpent;

  TimerProvider() {
    startTimer();
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        _secondsSpent++;
        notifyListeners();
      },
    );
  }

  void stopTimer() {
    _timer?.cancel();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
