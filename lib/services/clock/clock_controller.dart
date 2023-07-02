import 'dart:async';
import 'package:flutter/material.dart';

import 'models/meridiem.dart';

/// A controller class designed for driving a clock interface in a Flutter application.
///
/// The [ClockController] is responsible for managing the current time and facilitating the rendering of an analog
/// clock. Additionally, it features an alarm clock functionality, enabling the setting of an alarm time and notifying
/// listeners when the alarm time is reached.
///
/// The class listens to the 'ticks' of the clock every second and updates the current time.
///
/// Example:
/// ```dart
/// ClockController clockController = ClockController(type: ClockType.digital);
/// clockController.addListener(() {
///   // Perform actions each second as the clock ticks, like updating the UI
/// });
///
/// // Set the alarm to trigger at a specific DateTime
/// clockController.setAlarm(DateTime.now().add(Duration(minutes: 10)));
///
/// // Listen for when the alarm is triggered
/// clockController.alarmTriggered.listen((_) {
///   print('Alarm Triggered!');
/// });
/// ```
///
/// See also:
///
///  * [DateTime], which the `ClockController` uses to represent the current time and the alarm time.
///  * [StreamController], which is used for managing the alarm triggered event.
class ClockController with ChangeNotifier {
  /// The current time in 12-hour format.
  late DateTime _currentTime;

  // Getter for the current time
  DateTime get currentTime => _currentTime;

  /// A [DateTime] when the alarm will expire and alert the user.
  DateTime? _alarmTime;

  /// Method to set the alarm time.
  set alarmTime(DateTime alarmTime) {
    _alarmTime = alarmTime;
    _isAlarmTriggered = false;
  }

  /// A [Timer] used to update the values in this controller periodically.
  late Timer _timer;

  /// Determines if the alam has been triggered.
  bool _isAlarmTriggered = false;

  // Getter for the alarm triggered status
  bool get isAlarmTriggered => _isAlarmTriggered;

  /// Determines the meridiem of the current time.
  late Meridiem _meridiem;

  // Getter for the meridiem
  Meridiem get meridiem => _meridiem;

  ClockController() {
    _currentTime = _getCurrentTime();

    _meridiem = _currentTime.hour < 12 ? Meridiem.am : Meridiem.pm;

    // Schedule a tick to happen once every second
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) => _onTick());
  }

  /// Returns the current time in 12-hour format.
  ///
  /// This method retrieves the current time, converts it into 12-hour format,
  /// and returns a [DateTime] object. The hour component of the returned
  /// [DateTime] object will be in the range of 1 to 12 inclusive.
  DateTime _getCurrentTime() {
    final DateTime now = DateTime.now();
    int hours = now.hour;

    // Adjusting hours for 12-hour format
    if (hours > 12) {
      hours = hours - 12;
    } else if (hours == 0) {
      hours = 12;
    }

    _meridiem = hours < 12 ? Meridiem.am : Meridiem.pm;

    return DateTime(now.year, now.month, now.day, hours, now.minute, now.second);
  }

  /// Called every second.
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
