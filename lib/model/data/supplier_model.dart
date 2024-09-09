import 'package:hive/hive.dart';

part 'supplier_model.g.dart';

@HiveType(typeId: 6)
class Supplier {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String nama;

  @HiveField(2)
  final String alamat;

  @HiveField(3)
  final String nomorTelepon;

  @HiveField(4)
  final String email;

  Supplier({
    required this.id,
    required this.nama,
    required this.alamat,
    required this.nomorTelepon,
    required this.email,
  });
}
