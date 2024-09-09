// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'penjualan_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PenjualanAdapter extends TypeAdapter<Penjualan> {
  @override
  final int typeId = 1;

  @override
  Penjualan read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Penjualan(
      id: fields[0] as String,
      barang: fields[1] as Barang,
      jumlah: fields[2] as int,
      tanggalPenjualan: fields[3] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, Penjualan obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.barang)
      ..writeByte(2)
      ..write(obj.jumlah)
      ..writeByte(3)
      ..write(obj.tanggalPenjualan);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PenjualanAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
