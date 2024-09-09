// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stock_keluar_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StockKeluarAdapter extends TypeAdapter<StockKeluar> {
  @override
  final int typeId = 3;

  @override
  StockKeluar read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StockKeluar(
      id: fields[0] as String,
      barang: fields[1] as Barang,
      jumlah: fields[2] as int,
      tanggalKeluar: fields[3] as DateTime,
      karyawan: fields[4] as Karyawan,
    );
  }

  @override
  void write(BinaryWriter writer, StockKeluar obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.barang)
      ..writeByte(2)
      ..write(obj.jumlah)
      ..writeByte(3)
      ..write(obj.tanggalKeluar)
      ..writeByte(4)
      ..write(obj.karyawan);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StockKeluarAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
