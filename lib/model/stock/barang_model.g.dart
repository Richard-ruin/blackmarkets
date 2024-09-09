// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'barang_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BarangAdapter extends TypeAdapter<Barang> {
  @override
  final int typeId = 0;

  @override
  Barang read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Barang(
      id: fields[0] as String,
      nama: fields[1] as String,
      kategori: fields[2] as String,
      harga: fields[3] as double,
      stok: fields[4] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Barang obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.nama)
      ..writeByte(2)
      ..write(obj.kategori)
      ..writeByte(3)
      ..write(obj.harga)
      ..writeByte(4)
      ..write(obj.stok);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BarangAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
