// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ScoreModelAdapter extends TypeAdapter<ScoreModel> {
  @override
  final int typeId = 1;

  @override
  ScoreModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ScoreModel(
      leftTeamName: fields[0] as String,
      rightTeamName: fields[1] as String,
      leftTeamScore: fields[2] as String,
      rightTeamScore: fields[3] as String,
      startDateTime: fields[4] as String,
      endDateTime: fields[5] as String,
      winner: fields[6] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ScoreModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.leftTeamName)
      ..writeByte(1)
      ..write(obj.rightTeamName)
      ..writeByte(2)
      ..write(obj.leftTeamScore)
      ..writeByte(3)
      ..write(obj.rightTeamScore)
      ..writeByte(4)
      ..write(obj.startDateTime)
      ..writeByte(5)
      ..write(obj.endDateTime)
      ..writeByte(6)
      ..write(obj.winner);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ScoreModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
