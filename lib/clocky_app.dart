import 'package:clocky_mc_clockface/screens/clock/clock_types_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

/// A wrapper for the entire app, containing the base [MaterialApp] widget.
class ClockyApp extends StatelessWidget {
  const ClockyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Clocky McClockface',
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'), // English
      ],
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.pink,
        ),
        primaryColorDark: Colors.black,
        primaryColorLight: Colors.white,
        useMaterial3: true,
      ),
      home: const ClockTypesRoute(),
    );
  }
}
