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


/// A versatile clock widget for displaying time in a Flutter application.
///
/// The [Clock] widget can be used to display time in either digital or analog format.
/// It automatically updates every second to show the current time.
///
/// The type of clock (analog or digital) can be specified using the [clockType] property.
///
/// Example:
/// ```dart
/// Clock(clockType: ClockType.digital)
/// ```
///
/// Example:
/// ```dart
/// Clock(clockType: ClockType.analog)
/// ```
///
/// The [ClockType] enum is used to specify the type of clock:
///   - `ClockType.digital` displays the time in digital format.
///   - `ClockType.analog` displays the time in analog format, complete with hour,
///     minute, and second hands, and includes the numbers 12, 3, 6, and 9 in their
///     appropriate positions around the clock face with small lines for each
///     5-minute increment between these values.
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
              width: 350,
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
                    fontSize: 56,
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
