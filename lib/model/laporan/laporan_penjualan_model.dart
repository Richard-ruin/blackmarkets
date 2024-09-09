import 'package:hive/hive.dart';
import 'package:blackmarket/model/penjualan/penjualan_model.dart';

part 'laporan_penjualan_model.g.dart';

@HiveType(typeId: 8)
class LaporanPenjualan extends HiveObject {
  @HiveField(0)
  DateTime tanggal;

  @HiveField(1)
  int jumlahPembeli;

  @HiveField(2)
  int totalQty;

  @HiveField(3)
  double totalHarga;

  LaporanPenjualan({
    required this.tanggal,
    required this.jumlahPembeli,
    required this.totalQty,
    required this.totalHarga,
  });
}
