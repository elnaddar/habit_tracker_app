import 'package:flutter/material.dart';
import 'package:habit_tracker_app/pages/habit_form.dart';

import '/pages/pages.dart';

final Map<String, Widget Function(BuildContext)> routes = {
  "/": (context) => const HomePage(),
  // "/add_habit": (context) => const CreateNewHabit(),
};

Route<dynamic>? onGenerateRoute(RouteSettings settings) {
  if (settings.name == '/add_habit') {
    final args = (settings.arguments as Map<String, dynamic>?) ?? {};
    return MaterialPageRoute(
      builder: (context) {
        return HabitForm(
          habit: args['habit'],
        );
      },
    );
  }
  // Handle other routes if necessary
  return null;
}
