import 'package:flutter/material.dart';
import 'package:price_tracker/routes/router_names.dart';
import 'package:price_tracker/screens/price_tracker/price_tracker_screen.dart';
Route onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case priceTracker:
      return MaterialPageRoute(
          builder: (context) => ScreenTracker(), settings: settings);

        default:
      return MaterialPageRoute(builder: (context) => ScreenTracker());
  }
}
