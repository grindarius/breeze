import 'package:breeze/models/habit.dart';

/// Model cass that helps transfer Habit data from main page to
/// Habit Description page.
class CurrentHabit {
  /// A Habit class that gets passed through
  final Habit habit;
  /// Specying which index it is for putting back at the same spot
  final int i;

  CurrentHabit(this.habit, this.i);
}
