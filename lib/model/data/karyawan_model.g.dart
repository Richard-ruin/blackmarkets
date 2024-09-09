// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'karyawan_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class KaryawanAdapter extends TypeAdapter<Karyawan> {
  @override
  final int typeId = 4;

  @override
  Karyawan read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Karyawan(
      id: fields[0] as String,
      nama: fields[1] as String,
      posisi: fields[2] as String,
      gaji: fields[3] as double,
      tanggalBergabung: fields[4] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, Karyawan obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.nama)
      ..writeByte(2)
      ..write(obj.posisi)
      ..writeByte(3)
      ..write(obj.gaji)
      ..writeByte(4)
      ..write(obj.tanggalBergabung);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is KaryawanAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
