import 'package:hive/hive.dart';
import 'package:blackmarket/model/stock/barang_model.dart';

part 'penjualan_model.g.dart';

@HiveType(typeId: 1)
class Penjualan extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  Barang barang;

  @HiveField(2)
  int jumlah;

  @HiveField(3)
  DateTime tanggalPenjualan;

  Penjualan({
    required this.id,
    required this.barang,
    required this.jumlah,
    required this.tanggalPenjualan,
  });
}
