import 'package:hive/hive.dart';
import 'package:blackmarket/model/stock/barang_model.dart';

part 'pembelian_model.g.dart';

@HiveType(typeId: 9)
class Pembelian extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  DateTime tanggalPembelian;

  @HiveField(2)
  String idSupplier;

  @HiveField(3)
  double totalPembelian;

  @HiveField(4)
  List<DetailPembelian> detailPembelian;

  Pembelian({
    required this.id,
    required this.tanggalPembelian,
    required this.idSupplier,
    required this.totalPembelian,
    required this.detailPembelian,
  });
}

@HiveType(typeId: 10)
class DetailPembelian extends HiveObject {
  @HiveField(0)
  String idProduk;

  @HiveField(1)
  int jumlah;

  @HiveField(2)
  double harga;

  DetailPembelian({
    required this.idProduk,
    required this.jumlah,
    required this.harga,
  });
}
