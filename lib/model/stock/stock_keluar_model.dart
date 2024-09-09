import 'package:hive/hive.dart';
import 'package:blackmarket/model/stock/barang_model.dart';
import 'package:blackmarket/model/data/karyawan_model.dart';

part 'stock_keluar_model.g.dart';

@HiveType(typeId: 3)
class StockKeluar extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  Barang barang;

  @HiveField(2)
  int jumlah;

  @HiveField(3)
  DateTime tanggalKeluar;

  @HiveField(4)
  Karyawan karyawan;

  StockKeluar({
    required this.id,
    required this.barang,
    required this.jumlah,
    required this.tanggalKeluar,
    required this.karyawan,
  });
}
