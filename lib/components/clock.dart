import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/clock/clock_controller.dart';

/// A controller class designed for driving a clock interface in a Flutter application.
///
/// The `ClockController` is responsible for managing the current time and facilitating the rendering of an analog
/// clock. Additionally, it features an alarm clock functionality, enabling the setting of an alarm time and notifying
/// listeners when the alarm time is reached.
///
/// The class listens to the 'ticks' of the clock every second and updates the current time.
///
/// Example:
/// ```dart
/// ClockController clockController = ClockController();
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
class Clock extends StatelessWidget {
  const Clock({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ClockController(),
      child: Consumer<ClockController>(
        builder: (context, controller, child) {
          // Extract hours, minutes, and seconds from the current time
          int hours = controller.currentTime.hour;
          int minutes = controller.currentTime.minute;
          int seconds = controller.currentTime.second;

          // Check if the alarm has been triggered
          if (controller.isAlarmTriggered) {
            // Show an alert dialog
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Alarm'),
                  content: const Text('Good morning, starshine, The Earth Says "Hello!”'),
                  actions: [
                    TextButton(
                      child: const Text('OK'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    )
                  ],
                );
              },
            );
          }

          // Render the clock using hours, minutes, and seconds
          // TODO build a clock UI
          return Text('$hours:$minutes:$seconds');
        },
      ),
    );
  }
}
