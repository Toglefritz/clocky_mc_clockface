import 'package:flutter/material.dart';

import 'clock_types_route.dart';
import 'clock_types_view.dart';

/// A controller for the [ClockTypesRoute].
class ClockTypesController extends State<ClockTypesRoute> {
  @override
  Widget build(BuildContext context) => ClockTypesView(this);
}