import 'package:clocky_mc_clockface/services/clock/models/meridiem.dart';
import 'package:flutter/material.dart';

/// Indicates the current meridiem by displaying an "AM" or "PM" label.
class MeridiemIndicator extends StatelessWidget {
  const MeridiemIndicator({
    super.key,
    required this.meridiem,
  });

  /// The meridiem of the current time.
  final Meridiem meridiem;

  @override
  Widget build(BuildContext context) {
    return Text(
      meridiem == Meridiem.am ? 'AM' : 'PM',
      style: Theme.of(context).textTheme.labelMedium,
    );
  }
}
