import 'dart:async';
import 'package:flutter/material.dart';


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
