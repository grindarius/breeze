import 'package:hive/hive.dart';

import 'package:breeze/models/habit_type.dart';

part 'habit.g.dart';

/// A Model class for storing activities of each habit
@HiveType(typeId: 0)
class Habit {
  /// The name of the habit.
  @HiveField(0)
  final String name;

  /// The goal of the habit.
  @HiveField(1)
  final String goal;

  /// Which type of habit it is. only 2 possible, yes or no, and measurable.
  @HiveField(2)
  final HabitType type;

  /// Result of the Yes no method, this MUST be empty list if the type is measurable.
  @HiveField(3)
  final List<String> daysDoneYesNo;

  /// Result of the measurable method, this MUST be empty map if the type is Yes no.
  @HiveField(4)
  final Map<String, int> daysDoneMeasurable;

  /// How many times you have to do the measurable deed to be done.
  @HiveField(5)
  final int measurableDone;

  Habit({
    required this.name,
    required this.goal,
    required this.type,
    required this.daysDoneYesNo,
    required this.daysDoneMeasurable,
    required this.measurableDone,
  });
}
