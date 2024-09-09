// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'laporan_penjualan_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LaporanPenjualanAdapter extends TypeAdapter<LaporanPenjualan> {
  @override
  final int typeId = 8;

  @override
  LaporanPenjualan read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LaporanPenjualan(
      tanggal: fields[0] as DateTime,
      jumlahPembeli: fields[1] as int,
      totalQty: fields[2] as int,
      totalHarga: fields[3] as double,
    );
  }

  @override
  void write(BinaryWriter writer, LaporanPenjualan obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.tanggal)
      ..writeByte(1)
      ..write(obj.jumlahPembeli)
      ..writeByte(2)
      ..write(obj.totalQty)
      ..writeByte(3)
      ..write(obj.totalHarga);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LaporanPenjualanAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
