import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../components/clock.dart';
import 'clock_types_controller.dart';

/// A view for the [ClockTypesRoute] presenting a [TabBar] allowing the choice between a digital and an analog
/// clock.
class ClockTypesView extends StatelessWidget {
  final ClockTypesController state;

  const ClockTypesView(this.state, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 2,
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColorLight.withOpacity(0.1),
          title: Text(
            AppLocalizations.of(context).appTitle,
            style: GoogleFonts.orbitron().copyWith(
              color: Theme.of(context).primaryColorDark,
              fontWeight: FontWeight.bold,
            ),
          ),
          bottom: TabBar(
            labelColor: Theme.of(context).primaryColorLight,
            labelStyle: Theme.of(context).textTheme.headlineSmall,
            unselectedLabelColor: Theme.of(context).primaryColorDark,
            indicatorColor: Theme.of(context).primaryColorLight,
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorWeight: 3.0,
            tabs: <Widget>[
              Tab(
                icon: Text(
                  AppLocalizations.of(context).analog,
                ),
              ),
              Tab(
                icon: Text(
                  AppLocalizations.of(context).digital,
                ),
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: <Widget>[
            Center(
              child: Clock(
                clockType: ClockType.analog,
              ),
            ),
            Center(
              child: Clock(
                clockType: ClockType.digital,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
