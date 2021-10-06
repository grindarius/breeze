import 'package:flutter/material.dart';

import 'package:breeze/models/current_habit.dart';
import 'package:breeze/models/habit.dart';
import 'package:breeze/models/habit_type.dart';
import 'package:breeze/views/create_new_habit.dart';
import 'package:breeze/views/habit_description.dart';
import 'package:breeze/views/home.dart';
import 'package:breeze/views/update_habit.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case HomePage.route:
      return MaterialPageRoute(builder: (context) => const HomePage());
    case CreateNewHabitPage.route:
      return MaterialPageRoute(builder: (context) => const CreateNewHabitPage());
    case HabitDescriptionPage.route:
      final CurrentHabit arguments = settings.arguments as CurrentHabit? ??
        CurrentHabit(Habit(
          name: '',
          goal: '',
          type: HabitType.yesOrNo,
          daysDoneYesNo: [],
          daysDoneMeasurable: {},
          measurableDone: 0,
        ), 0);

      return MaterialPageRoute(builder: (context) => HabitDescriptionPage(currentHabit: arguments));
    case UpdateHabitPage.route:
      final CurrentHabit arguments = settings.arguments as CurrentHabit? ??
        CurrentHabit(Habit(
          name: '',
          goal: '',
          type: HabitType.yesOrNo,
          daysDoneYesNo: [],
          daysDoneMeasurable: {},
          measurableDone: 0,
        ), 0);

      return MaterialPageRoute(builder: (context) => UpdateHabitPage(currentHabit: arguments));
    default:
      return MaterialPageRoute(builder: (context) => const HomePage());
  }  
}
