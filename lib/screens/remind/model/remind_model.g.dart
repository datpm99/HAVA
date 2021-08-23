// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remind_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RemindModelAdapter extends TypeAdapter<RemindModel> {
  @override
  final typeId = 1;

  @override
  RemindModel read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RemindModel(
      id: fields[0] as int,
      title: fields[1] as String,
      time: fields[2] as String,
      isAlarm: fields[3] as bool,
      listRepeat: fields[4] as List<int>,
      isDefault: fields[5] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, RemindModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.time)
      ..writeByte(3)
      ..write(obj.isAlarm)
      ..writeByte(4)
      ..write(obj.listRepeat)
      ..writeByte(5)
      ..write(obj.isDefault);
  }
}
