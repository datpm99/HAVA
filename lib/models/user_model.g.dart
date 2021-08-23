// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserModelAdapter extends TypeAdapter<UserModel> {
  @override
  final int typeId = 2;

  @override
  UserModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserModel(
      userId: fields[0] as int,
      userName: fields[1] as String,
      userEmail: fields[2] as String,
      userPhone: fields[3] as String,
      userAvatar: fields[4] as String,
      birthDay: fields[5] as String,
      sex: fields[6] as int,
      userToken: fields[7] as String,
      isSocial: fields[8] as int,
      isMath: fields[9] as bool,
      isPhysics: fields[10] as bool,
      isChemistry: fields[11] as bool,
      isBiology: fields[12] as bool,
      isEnglish: fields[13] as bool,
      isLiterature: fields[14] as bool,
      isGeography: fields[15] as bool,
      isGDCD: fields[16] as bool,
      isHistory: fields[17] as bool,
      address: fields[18] as String,
      school: fields[19] as String,
      classBelong: fields[20] as String,
    );
  }

  @override
  void write(BinaryWriter writer, UserModel obj) {
    writer
      ..writeByte(21)
      ..writeByte(0)
      ..write(obj.userId)
      ..writeByte(1)
      ..write(obj.userName)
      ..writeByte(2)
      ..write(obj.userEmail)
      ..writeByte(3)
      ..write(obj.userPhone)
      ..writeByte(4)
      ..write(obj.userAvatar)
      ..writeByte(5)
      ..write(obj.birthDay)
      ..writeByte(6)
      ..write(obj.sex)
      ..writeByte(7)
      ..write(obj.userToken)
      ..writeByte(8)
      ..write(obj.isSocial)
      ..writeByte(9)
      ..write(obj.isMath)
      ..writeByte(10)
      ..write(obj.isPhysics)
      ..writeByte(11)
      ..write(obj.isChemistry)
      ..writeByte(12)
      ..write(obj.isBiology)
      ..writeByte(13)
      ..write(obj.isEnglish)
      ..writeByte(14)
      ..write(obj.isLiterature)
      ..writeByte(15)
      ..write(obj.isGeography)
      ..writeByte(16)
      ..write(obj.isGDCD)
      ..writeByte(17)
      ..write(obj.isHistory)
      ..writeByte(18)
      ..write(obj.address)
      ..writeByte(19)
      ..write(obj.school)
      ..writeByte(20)
      ..write(obj.classBelong);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
