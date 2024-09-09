// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kategori_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class KategoriAdapter extends TypeAdapter<Kategori> {
  @override
  final int typeId = 7;

  @override
  Kategori read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Kategori(
      id: fields[0] as String,
      nama: fields[1] as String,
      deskripsi: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Kategori obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.nama)
      ..writeByte(2)
      ..write(obj.deskripsi);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is KategoriAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
