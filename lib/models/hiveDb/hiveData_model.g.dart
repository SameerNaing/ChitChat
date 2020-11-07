// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hiveData_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AccountsAdapter extends TypeAdapter<Accounts> {
  @override
  final int typeId = 0;

  @override
  Accounts read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Accounts(
      userName: fields[0] as String,
      profilePhoto: fields[1] as String,
      email: fields[2] as String,
      password: fields[3] as String,
      uid: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Accounts obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.userName)
      ..writeByte(1)
      ..write(obj.profilePhoto)
      ..writeByte(2)
      ..write(obj.email)
      ..writeByte(3)
      ..write(obj.password)
      ..writeByte(4)
      ..write(obj.uid);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AccountsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
