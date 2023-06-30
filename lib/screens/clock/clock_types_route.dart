import 'package:flutter/material.dart';

import 'clock_types_controller.dart';

/// Presents and interface allowing for the choice between an analog and a digital clock.
class ClockTypesRoute extends StatefulWidget {
  const ClockTypesRoute({super.key});

  @override
  ClockTypesController createState() => ClockTypesController();
}