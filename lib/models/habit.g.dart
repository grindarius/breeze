// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'habit.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HabitAdapter extends TypeAdapter<Habit> {
  @override
  final int typeId = 0;

  @override
  Habit read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Habit(
      name: fields[0] as String,
      goal: fields[1] as String,
      type: fields[2] as HabitType,
      daysDoneYesNo: (fields[3] as List).cast<String>(),
      daysDoneMeasurable: (fields[4] as Map).cast<String, int>(),
      measurableDone: fields[5] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Habit obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.goal)
      ..writeByte(2)
      ..write(obj.type)
      ..writeByte(3)
      ..write(obj.daysDoneYesNo)
      ..writeByte(4)
      ..write(obj.daysDoneMeasurable)
      ..writeByte(5)
      ..write(obj.measurableDone);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HabitAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
