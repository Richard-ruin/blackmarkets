import 'package:hive/hive.dart';
import 'package:blackmarket/model/stock/barang_model.dart';
import 'package:blackmarket/model/data/supplier_model.dart';

part 'stock_masuk_model.g.dart';

@HiveType(typeId: 2)
class StockMasuk extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  Barang barang;

  @HiveField(2)
  int jumlah;

  @HiveField(3)
  DateTime tanggalMasuk;

  @HiveField(4)
  Supplier supplier;

  StockMasuk({
    required this.id,
    required this.barang,
    required this.jumlah,
    required this.tanggalMasuk,
    required this.supplier,
  });
}
