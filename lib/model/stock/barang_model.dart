import 'package:hive/hive.dart';

part 'barang_model.g.dart';

@HiveType(typeId: 0)
class Barang extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String nama;

  @HiveField(2)
  String kategori;

  @HiveField(3)
  double harga;

  @HiveField(4)
  int stok;

  Barang(
      {required this.id,
      required this.nama,
      required this.kategori,
      required this.harga,
      required this.stok});
}
