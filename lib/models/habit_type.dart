import 'package:hive/hive.dart';

part 'habit_type.g.dart';

/// An enum specifying what type of Habit is for UI rendering purposes.
@HiveType(typeId: 1)
enum HabitType {
  /// A Yes or No Habit is a type of habit where only one time per measuring unit is needed.
  @HiveField(0)
  yesOrNo,

  /// A Measurable Habit is a type of habit where multiple times of habit
  /// is needed per measuring unit.
  @HiveField(1)
  measurable
}
