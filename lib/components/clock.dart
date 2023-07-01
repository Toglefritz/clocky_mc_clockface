import 'package:clocky_mc_clockface/extensions/int_extensions.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:analog_clock/analog_clock.dart';

import '../services/clock/clock_controller.dart';

/// An enumeration of clock types, used to change the appearance of the
/// [Clock] widget.
enum ClockType {
  digital,
  analog,
}

/// A controller class designed for driving a clock interface in a Flutter application.
///
/// The [ClockController] is responsible for managing the current time and facilitating the rendering of an analog
/// clock. Additionally, it features an alarm clock functionality, enabling the setting of an alarm time and notifying
/// listeners when the alarm time is reached.
///
/// The clock UI can be rendered in multiple different ways, depending upon the value of [clockType].
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
class Clock extends StatelessWidget {
  const Clock({
    super.key,
    required this.clockType,
  });

  final ClockType clockType;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ClockController(),
      child: Consumer<ClockController>(
        builder: (BuildContext context, ClockController controller, Widget? child) {
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

          // Render the clock using hours, minutes, and seconds, in a style dependent on [clockType]
          // Digital clock
          if (clockType == ClockType.digital) {
            return Container(
              width: 400,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 2.0,
                  color: Theme.of(context).primaryColorDark,
                ),
                borderRadius: BorderRadius.circular(10.0),
                color: Theme.of(context).primaryColorLight.withOpacity(0.1),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Text(
                  '${hours.toZeroPaddedString()}:${minutes.toZeroPaddedString()}:${seconds.toZeroPaddedString()}',
                  style: GoogleFonts.orbitron().copyWith(
                    fontSize: 64,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }
          // Analog clock
          else {
            return AnalogClock(
              decoration: BoxDecoration(
                border: Border.all(
                  width: 2.0,
                  color: Theme.of(context).primaryColorDark,
                ),
                color: Theme.of(context).primaryColorLight.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              width: 350.0,
              isLive: true,
              hourHandColor: Theme.of(context).primaryColorDark,
              minuteHandColor: Theme.of(context).primaryColorDark,
              showSecondHand: true,
              secondHandColor: Theme.of(context).colorScheme.secondary,
              numberColor: Theme.of(context).primaryColorDark.withOpacity(0.87),
              showNumbers: true,
              showAllNumbers: false,
              textScaleFactor: 1.5,
              showTicks: true,
              tickColor: Theme.of(context).primaryColorDark,
              showDigitalClock: false,
              datetime: controller.currentTime,
            );
          }
        },
      ),
    );
  }
}
