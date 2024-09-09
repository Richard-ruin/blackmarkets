// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pembelian_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PembelianAdapter extends TypeAdapter<Pembelian> {
  @override
  final int typeId = 9;

  @override
  Pembelian read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Pembelian(
      id: fields[0] as String,
      tanggalPembelian: fields[1] as DateTime,
      idSupplier: fields[2] as String,
      totalPembelian: fields[3] as double,
      detailPembelian: (fields[4] as List).cast<DetailPembelian>(),
    );
  }

  @override
  void write(BinaryWriter writer, Pembelian obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.tanggalPembelian)
      ..writeByte(2)
      ..write(obj.idSupplier)
      ..writeByte(3)
      ..write(obj.totalPembelian)
      ..writeByte(4)
      ..write(obj.detailPembelian);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PembelianAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class DetailPembelianAdapter extends TypeAdapter<DetailPembelian> {
  @override
  final int typeId = 10;

  @override
  DetailPembelian read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DetailPembelian(
      idProduk: fields[0] as String,
      jumlah: fields[1] as int,
      harga: fields[2] as double,
    );
  }

  @override
  void write(BinaryWriter writer, DetailPembelian obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.idProduk)
      ..writeByte(1)
      ..write(obj.jumlah)
      ..writeByte(2)
      ..write(obj.harga);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DetailPembelianAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
