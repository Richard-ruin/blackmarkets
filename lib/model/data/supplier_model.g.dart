// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'supplier_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SupplierAdapter extends TypeAdapter<Supplier> {
  @override
  final int typeId = 6;

  @override
  Supplier read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Supplier(
      id: fields[0] as String,
      nama: fields[1] as String,
      alamat: fields[2] as String,
      nomorTelepon: fields[3] as String,
      email: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Supplier obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.nama)
      ..writeByte(2)
      ..write(obj.alamat)
      ..writeByte(3)
      ..write(obj.nomorTelepon)
      ..writeByte(4)
      ..write(obj.email);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SupplierAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
