// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gender.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GenderAdapter extends TypeAdapter<Gender> {
  @override
  final int typeId = 1;

  @override
  Gender read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return Gender.FEMALE;
      case 1:
        return Gender.MALE;
      case 2:
        return Gender.OTHER;
      default:
        return Gender.FEMALE;
    }
  }

  @override
  void write(BinaryWriter writer, Gender obj) {
    switch (obj) {
      case Gender.FEMALE:
        writer.writeByte(0);
        break;
      case Gender.MALE:
        writer.writeByte(1);
        break;
      case Gender.OTHER:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GenderAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
