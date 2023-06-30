import 'dart:async';
import 'package:flutter/material.dart';

class ClockController with ChangeNotifier {
  late DateTime _currentTime;
  DateTime? _alarmTime;
  late Timer _timer;
  bool _isAlarmTriggered = false;

  ClockController() {
    _currentTime = DateTime.now();
    // Schedule a tick to happen once every second
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) => _onTick());
  }

  // Getter for the current time
  DateTime get currentTime => _currentTime;

  // Getter for the alarm triggered status
  bool get isAlarmTriggered => _isAlarmTriggered;

  // Method to set the alarm time
  void setAlarm(DateTime alarmTime) {
    _alarmTime = alarmTime;
    _isAlarmTriggered = false;
  }

  // Called every second
  void _onTick() {
    _currentTime = DateTime.now();
    // Check if the current time has reached the alarm time
    if (_alarmTime != null && _currentTime.isAfter(_alarmTime!) && !_isAlarmTriggered) {
      _isAlarmTriggered = true;
      // Notify listeners that the alarm has triggered
      notifyListeners();
    }
    // Notify listeners for the time update
    notifyListeners();
  }

  // Cancel the timer when the object is disposed
  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
