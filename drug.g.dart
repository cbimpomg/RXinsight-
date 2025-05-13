// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drug.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DrugAdapter extends TypeAdapter<Drug> {
  @override
  final int typeId = 0;

  @override
  Drug read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Drug(
      id: fields[0] as String,
      name: fields[1] as String,
      uses: fields[2] as String,
      sideEffects: fields[3] as String,
      interactions: (fields[4] as List).cast<String>(),
      dosageInfo: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Drug obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.uses)
      ..writeByte(3)
      ..write(obj.sideEffects)
      ..writeByte(4)
      ..write(obj.interactions)
      ..writeByte(5)
      ..write(obj.dosageInfo);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DrugAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
