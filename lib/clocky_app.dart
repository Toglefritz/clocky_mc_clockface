import 'package:clocky_mc_clockface/screens/clock/clock_types_route.dart';
import 'package:flutter/material.dart';

/// A wrapper for the entire app, containing the base [MaterialApp] widget.
class ClockyApp extends StatelessWidget {
  const ClockyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Clocky McClockface',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.pink,
        ),
        useMaterial3: true,
      ),
      home: const ClockTypesRoute(),
    );
  }
}
