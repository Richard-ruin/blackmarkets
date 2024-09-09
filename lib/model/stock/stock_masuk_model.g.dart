// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stock_masuk_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StockMasukAdapter extends TypeAdapter<StockMasuk> {
  @override
  final int typeId = 2;

  @override
  StockMasuk read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StockMasuk(
      id: fields[0] as String,
      barang: fields[1] as Barang,
      jumlah: fields[2] as int,
      tanggalMasuk: fields[3] as DateTime,
      supplier: fields[4] as Supplier,
    );
  }

  @override
  void write(BinaryWriter writer, StockMasuk obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.barang)
      ..writeByte(2)
      ..write(obj.jumlah)
      ..writeByte(3)
      ..write(obj.tanggalMasuk)
      ..writeByte(4)
      ..write(obj.supplier);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StockMasukAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
